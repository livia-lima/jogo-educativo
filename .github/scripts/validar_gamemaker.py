#!/usr/bin/env python3
"""Validação estática do projeto GameMaker (roda no CI, sem precisar do GameMaker).

Confere o que costuma quebrar quando cada pessoa sobe a sua parte numa branch:
  - .yyp e .yy que não abrem (JSON do GameMaker inválido, conflito de merge mal resolvido);
  - recurso listado no .yyp sem pasta/arquivo, ou pasta de recurso que não está no .yyp;
  - referências quebradas: sprite de objeto, objeto de instância em room, pasta "parent",
    room na ordem de rooms, arquivo de creation code, frames de sprite, arquivo de som;
  - eventos de objeto sem o .gml correspondente (e .gml que nenhum evento usa);
  - GML com chaves/parênteses/colchetes desbalanceados ou usando asset que não existe
    (ex.: room_goto(rm_que_nao_existe));
  - marcadores de conflito (<<<<<<<) esquecidos em qualquer arquivo de texto.

Uso: python3 .github/scripts/validar_gamemaker.py [caminho/do/projeto.yyp]
Sai com código 1 se houver erro. Avisos não reprovam o CI.
"""
from __future__ import annotations

import json
import os
import re
import subprocess
import sys
from pathlib import Path

RAIZ_REPO = Path(__file__).resolve().parents[2]

# Tipos de evento do GameMaker -> prefixo do arquivo .gml
EVENTOS = {
    0: "Create", 1: "Destroy", 2: "Alarm", 3: "Step", 4: "Collision", 5: "Keyboard",
    6: "Mouse", 7: "Other", 8: "Draw", 9: "KeyPress", 10: "KeyRelease", 12: "CleanUp",
    13: "Gesture", 14: "PreCreate",
}
PASTAS_RECURSO = {
    "objects", "rooms", "scripts", "sounds", "sprites", "fonts", "shaders", "paths",
    "sequences", "tilesets", "timelines", "notes", "extensions", "animcurves",
}
PREFIXOS_ASSET = ("rm_", "obj_", "spr_", "snd_", "scr_", "fnt_", "sh_", "seq_", "ts_")

erros: list[str] = []
avisos: list[str] = []


def erro(msg: str) -> None:
    erros.append(msg)


def aviso(msg: str) -> None:
    avisos.append(msg)


# --------------------------------------------------------------------------- leitura .yy
def _tirar_virgulas_finais(texto: str) -> str:
    """O GameMaker grava JSON com vírgula antes de } e ]. Remove só fora de strings."""
    saida, i, n, em_string = [], 0, len(texto), False
    while i < n:
        c = texto[i]
        if em_string:
            saida.append(c)
            if c == "\\" and i + 1 < n:
                saida.append(texto[i + 1])
                i += 2
                continue
            if c == '"':
                em_string = False
        elif c == '"':
            em_string = True
            saida.append(c)
        elif c == ",":
            j = i + 1
            while j < n and texto[j] in " \t\r\n":
                j += 1
            if j < n and texto[j] in "}]":
                i += 1
                continue
            saida.append(c)
        else:
            saida.append(c)
        i += 1
    return "".join(saida)


def ler_yy(caminho: Path, rel: str) -> dict | None:
    try:
        texto = caminho.read_text(encoding="utf-8-sig")
    except FileNotFoundError:
        erro(f"{rel}: arquivo não existe")
        return None
    try:
        return json.loads(_tirar_virgulas_finais(texto))
    except json.JSONDecodeError as e:
        erro(f"{rel}: JSON inválido (linha {e.lineno}, coluna {e.colno}): {e.msg}")
        return None


# --------------------------------------------------------------------------- GML
_RE_TOKEN_GML = re.compile(
    r'//[^\n]*|/\*.*?\*/|@"[^"]*"|@\'[^\']*\'|"(?:\\.|[^"\\\n])*"|\'(?:\\.|[^\'\\\n])*\'',
    re.S,
)


def limpar_gml(codigo: str) -> str:
    """Remove comentários e strings, mantendo as quebras de linha (para numerar erros)."""
    return _RE_TOKEN_GML.sub(lambda m: re.sub(r"[^\n]", " ", m.group(0)), codigo)


def checar_balanceamento(codigo_limpo: str, rel: str) -> None:
    pares = {")": "(", "]": "[", "}": "{"}
    pilha: list[tuple[str, int]] = []
    for num, linha in enumerate(codigo_limpo.splitlines(), 1):
        for c in linha:
            if c in "([{":
                pilha.append((c, num))
            elif c in pares:
                if not pilha or pilha[-1][0] != pares[c]:
                    erro(f"{rel}:{num}: '{c}' sem abertura correspondente")
                    return
                pilha.pop()
    if pilha:
        c, num = pilha[-1]
        erro(f"{rel}:{num}: '{c}' aberto e nunca fechado")


# --------------------------------------------------------------------------- projeto
def validar_projeto(yyp: Path) -> None:
    base = yyp.parent
    rel_base = base.relative_to(RAIZ_REPO).as_posix() if base.is_relative_to(RAIZ_REPO) else str(base)

    def rel(p: str | Path) -> str:
        return f"{rel_base}/{Path(p).as_posix()}"

    projeto = ler_yy(yyp, rel(yyp.name))
    if projeto is None:
        return

    # Pastas virtuais do IDE
    pastas = {f["folderPath"] for f in projeto.get("Folders", [])}
    pastas.add(yyp.name)

    # Recursos
    recursos: dict[str, str] = {}
    for item in projeto.get("resources", []):
        nome, caminho = item["id"]["name"], item["id"]["path"]
        if nome in recursos:
            erro(f"{rel(yyp.name)}: recurso '{nome}' listado mais de uma vez")
        recursos[nome] = caminho
        if not (base / caminho).is_file():
            erro(f"{rel(yyp.name)}: recurso '{nome}' aponta para '{caminho}', que não existe")

    caminhos_listados = {Path(p).parent.as_posix() for p in recursos.values()}
    for tipo in sorted(PASTAS_RECURSO):
        pasta = base / tipo
        if not pasta.is_dir():
            continue
        for sub in sorted(pasta.iterdir()):
            if sub.is_dir() and f"{tipo}/{sub.name}" not in caminhos_listados:
                erro(f"{rel(f'{tipo}/{sub.name}')}: pasta de recurso que não está no .yyp "
                     f"(o GameMaker ignora; adicione ao .yyp ou apague)")

    for no in projeto.get("RoomOrderNodes", []):
        nome = no["roomId"]["name"]
        if nome not in recursos:
            erro(f"{rel(yyp.name)}: RoomOrderNodes cita '{nome}', que não é recurso do projeto")
    rooms_na_ordem = {no["roomId"]["name"] for no in projeto.get("RoomOrderNodes", [])}
    for nome, caminho in recursos.items():
        if caminho.startswith("rooms/") and nome not in rooms_na_ordem:
            erro(f"{rel(yyp.name)}: room '{nome}' não está em RoomOrderNodes")

    for inc in projeto.get("IncludedFiles", []):
        arq = base / inc["filePath"] / inc["name"]
        if not arq.is_file():
            erro(f"{rel(yyp.name)}: included file '{inc['filePath']}/{inc['name']}' não existe")

    def checar_ref(ref, origem: str, campo: str) -> None:
        if ref is None:
            return
        nome = ref.get("name")
        if nome not in recursos:
            erro(f"{origem}: {campo} '{nome}' não existe no projeto")

    gml_arquivos: list[Path] = []

    for nome, caminho in sorted(recursos.items()):
        arq = base / caminho
        if not arq.is_file():
            continue
        dados = ler_yy(arq, rel(caminho))
        if dados is None:
            continue
        pasta_rec = arq.parent
        origem = rel(caminho)

        if dados.get("name") != nome:
            erro(f"{origem}: nome interno '{dados.get('name')}' difere do nome no .yyp '{nome}'")

        parent = dados.get("parent") or {}
        if parent.get("path") and parent["path"] not in pastas:
            erro(f"{origem}: pasta parent '{parent['path']}' não existe em Folders do .yyp")

        tipo = dados.get("resourceType")
        if tipo == "GMObject":
            checar_ref(dados.get("spriteId"), origem, "spriteId")
            checar_ref(dados.get("spriteMaskId"), origem, "spriteMaskId")
            checar_ref(dados.get("parentObjectId"), origem, "parentObjectId")
            esperados = set()
            for ev in dados.get("eventList", []):
                prefixo = EVENTOS.get(ev["eventType"])
                if prefixo is None:
                    aviso(f"{origem}: eventType {ev['eventType']} desconhecido")
                    continue
                if prefixo == "Collision":
                    alvo = (ev.get("collisionObjectId") or {}).get("name")
                    checar_ref(ev.get("collisionObjectId"), origem, "colisão com")
                    gml = f"Collision_{alvo}.gml"
                else:
                    gml = f"{prefixo}_{ev['eventNum']}.gml"
                esperados.add(gml)
                if not (pasta_rec / gml).is_file():
                    erro(f"{origem}: evento {prefixo}_{ev['eventNum']} sem o arquivo {gml}")
            for g in sorted(pasta_rec.glob("*.gml")):
                if g.name not in esperados:
                    aviso(f"{rel(Path(caminho).parent / g.name)}: .gml que nenhum evento usa "
                          f"(o GameMaker não executa)")
            gml_arquivos += [pasta_rec / g for g in esperados if (pasta_rec / g).is_file()]

        elif tipo == "GMRoom":
            cc = dados.get("creationCodeFile") or ""
            if cc:
                if not (base / cc).is_file():
                    erro(f"{origem}: creationCodeFile '{cc}' não existe "
                         f"(o GameMaker falha ao abrir/compilar; crie o arquivo, mesmo vazio)")
                else:
                    gml_arquivos.append(base / cc)
            pilha_camadas = list(dados.get("layers", []))
            while pilha_camadas:
                camada = pilha_camadas.pop()
                pilha_camadas += camada.get("layers", [])
                checar_ref(camada.get("spriteId"), origem, f"spriteId da camada '{camada.get('name')}'")
                checar_ref(camada.get("tilesetId"), origem, f"tileset da camada '{camada.get('name')}'")
                for inst in camada.get("instances", []):
                    checar_ref(inst.get("objectId"), origem, f"objeto da instância '{inst.get('name')}'")
                    if inst.get("hasCreationCode"):
                        icc = pasta_rec / f"InstanceCreationCode_{inst['name']}.gml"
                        if not icc.is_file():
                            erro(f"{origem}: instância '{inst['name']}' tem creation code mas falta {icc.name}")
                        else:
                            gml_arquivos.append(icc)
            for view in dados.get("views", []):
                checar_ref(view.get("objectId"), origem, "objeto seguido pela view")

        elif tipo == "GMSprite":
            for frame in dados.get("frames", []):
                fid = frame.get("name") or (frame.get("compositeImage") or {}).get("FrameId", {}).get("name")
                if fid and not (pasta_rec / f"{fid}.png").is_file():
                    erro(f"{origem}: frame '{fid}.png' não existe")
            for layer in dados.get("layers", []):
                lid = layer.get("name")
                for frame in dados.get("frames", []):
                    fid = frame.get("name")
                    if lid and fid and not (pasta_rec / "layers" / fid / f"{lid}.png").is_file():
                        erro(f"{origem}: imagem da camada 'layers/{fid}/{lid}.png' não existe")

        elif tipo == "GMSound":
            som = dados.get("soundFile")
            if som and not (pasta_rec / som).is_file():
                erro(f"{origem}: soundFile '{som}' não existe")

        elif tipo == "GMScript":
            gml = pasta_rec / f"{nome}.gml"
            if not gml.is_file():
                erro(f"{origem}: script sem o arquivo {nome}.gml")
            else:
                gml_arquivos.append(gml)

    # ----------------------------------------------------------------- GML
    codigos = {}
    for g in gml_arquivos:
        codigos[g] = limpar_gml(g.read_text(encoding="utf-8-sig", errors="replace"))

    # Nomes que o código define (funções, enums, macros, variáveis) com prefixo de asset
    definidos = set(recursos)
    for c in codigos.values():
        definidos |= set(re.findall(r"\bfunction\s+([A-Za-z_]\w*)", c))
        definidos |= set(re.findall(r"#macro\s+([A-Za-z_]\w*)", c))
        definidos |= set(re.findall(r"\benum\s+([A-Za-z_]\w*)", c))
        definidos |= set(re.findall(r"\bvar\s+([A-Za-z_]\w*)", c))
        definidos |= set(re.findall(r"\b([A-Za-z_]\w*)\s*=(?!=)", c))
        definidos |= set(re.findall(r"\bstatic\s+([A-Za-z_]\w*)", c))
        for params in re.findall(r"\bfunction\s*\w*\s*\(([^)]*)\)", c):
            definidos |= set(re.findall(r"([A-Za-z_]\w*)\s*(?:=|,|$)", params))

    re_asset = re.compile(r"(?<![\w.])((?:" + "|".join(PREFIXOS_ASSET) + r")\w+)\b")
    for g, c in sorted(codigos.items()):
        r = rel(g.relative_to(base))
        checar_balanceamento(c, r)
        for num, linha in enumerate(c.splitlines(), 1):
            for nome in re_asset.findall(linha):
                if nome not in definidos:
                    erro(f"{r}:{num}: usa '{nome}', que não existe no projeto")


# --------------------------------------------------------------------------- repo
def validar_conflitos() -> None:
    try:
        saida = subprocess.run(
            ["git", "grep", "-I", "-n", "-E", r"^(<<<<<<< |>>>>>>> |=======$)"],
            cwd=RAIZ_REPO, capture_output=True, text=True,
        )
    except FileNotFoundError:
        return
    for linha in saida.stdout.splitlines():
        erro(f"{linha.split(':', 2)[0]}:{linha.split(':', 2)[1]}: marcador de conflito de merge")


def main() -> int:
    if len(sys.argv) > 1:
        projetos = [Path(a).resolve() for a in sys.argv[1:]]
    else:
        projetos = sorted(p for p in (RAIZ_REPO / "game").rglob("*.yyp"))
    if not projetos:
        erro("nenhum arquivo .yyp encontrado em game/")
    for p in projetos:
        validar_projeto(p)
    validar_conflitos()

    gh = os.environ.get("GITHUB_ACTIONS") == "true"
    for a in avisos:
        print(f"::warning::{a}" if gh else f"AVISO  {a}")
    for e in erros:
        print(f"::error::{e}" if gh else f"ERRO   {e}")
    print(f"\n{len(erros)} erro(s), {len(avisos)} aviso(s) em {len(projetos)} projeto(s).")
    return 1 if erros else 0


if __name__ == "__main__":
    sys.exit(main())
