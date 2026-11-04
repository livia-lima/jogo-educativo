# Projeto GameMaker

Crie aqui o arquivo `.yyp` e os recursos gerenciados pelo GameMaker.

## Registro técnico

- **Versão do GameMaker:** a definir
- **Resolução-base:** a definir até 26/10/2026
- **Plataforma de demonstração:** a definir até 26/10/2026
- **Comando de execução:** abrir o `.yyp` e executar com `F6`

Não versionar builds nesta pasta. Guarde-as fora do repositório ou publique-as em GitHub Releases quando houver uma versão para demonstração.

## Telas do João (Explicações e Vitória)

Recursos na pasta **Joao (Explicações e Vitória)** do projeto:

- `obj_player_explicacao` — player único usado em `rm_fase1_explicacao` e `rm_fase2_explicacao`. Toca o vídeo da fase, se ele existir; caso contrário, mostra uma animação de demonstração (fallback) com legendas e voz. Botões **Pular**, **Ver de novo** e **Começar!** (Enter/Espaço também avançam).
- `obj_tela_parabens` — tela de vitória (`rm_parabens`): "Parabéns! Sua pontuação foi: …" com placar contando, confetes, dublagem e os botões **Ver ranking** (`rm_leaderboard`) e **Voltar ao menu** (`rm_start_screen`). Lê `global.pontuacao` e `global.nome_aluno`.
- `scr_explicacao` — roteiros das legendas (`legendas_fase1`, `legendas_fase2`), sincronização de voz e funções de desenho reaproveitáveis.

**Vídeos explicativos:** coloque os arquivos em *Included Files* como `videos/fase1_explicacao.mp4` e `videos/fase2_explicacao.mp4`. As legendas seguem a posição do vídeo; ajuste os tempos (em ms) em `legendas_fase1()` / `legendas_fase2()` para casar com a dublagem gravada.

**Fonte com acentos:** a fonte padrão do GameMaker não tem acentos, então o texto é exibido sem eles. Para mostrar os acentos, inclua uma fonte TTF em *Included Files* como `fonts/fonte_jogo.ttf`.
