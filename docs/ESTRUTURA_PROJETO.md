# Molde do projeto

Este molde foi pensado para um jogo acadêmico em GameMaker: simples de seguir, auditável para a disciplina e suficientemente organizado para continuar no portfólio.

## Primeiro uso

1. Uma pessoa do desenvolvimento cria o projeto GameMaker dentro de `game/`.
2. Registre em `game/README.md` a versão do GameMaker, a resolução-base e o dispositivo de demonstração.
3. A pessoa de design coloca arquivos editáveis em `assets/fonte/` e exports importáveis em `assets/exportados/`.
4. A pessoa responsável pelas regras registra cenários de aceite em `tests/casos/`.
5. Cada decisão técnica relevante recebe uma nota breve em `docs/arquitetura/`.

## Onde cada item deve ficar

| Item | Local | Regra |
|---|---|---|
| Arquivo `.yyp`, rooms, objetos e scripts | `game/` | Fonte executável do jogo; sempre versionar. |
| Imagem, áudio e fonte editáveis | `assets/fonte/`, `assets/audio/`, `assets/fontes/` | Registrar autoria/licença antes de publicar. |
| Arquivo pronto para importar | `assets/exportados/` | Usar nomes descritivos e manter a versão-fonte quando houver. |
| Casos de teste | `tests/casos/` | Um arquivo por fluxo ou conjunto pequeno de regras. |
| Evidência de testes | `docs/testes/` | Registrar data, build, resultado e bug encontrado. |
| Decisão técnica | `docs/arquitetura/` | Explicar contexto, decisão e consequência em poucas linhas. |
| Build para demonstração | `releases/` | Não versionar; publicar no GitHub Releases quando o remoto existir. |

## Convenções de nomes

- Use minúsculas, hífen e nomes objetivos: `tela-inicial`, `feedback-acerto`, `teste-reinicio`.
- Prefira nomes que expressem intenção a códigos genéricos como `img1` ou `novo-script`.
- Para assets, use um prefixo de tipo quando ajudar: `ui_botao-jogar`, `sfx_acerto`, `bg_sala-atividade`.

## Template de caso de teste

Copie este conteúdo ao criar um arquivo em `tests/casos/`:

```md
# CT-XX — Nome do fluxo

**Prioridade:** P0 | P1  
**Regra relacionada:** RN-XX / caso de uso correspondente

## Pré-condição

- Estado inicial necessário para executar o teste.

## Passos

1. Ação do jogador.
2. Próxima ação.

## Resultado esperado

- Feedback apresentado.
- Estado do jogo após a ação.
- Possibilidade de continuar, concluir ou reiniciar.
```

## Template de decisão técnica

```md
# Decisão — título curto

**Data:** AAAA-MM-DD  
**Responsável:** nome

## Contexto

Qual problema precisava ser resolvido?

## Decisão

O que a equipe decidiu implementar?

## Consequências

Quais benefícios, limitações ou tarefas futuras essa decisão cria?
```
