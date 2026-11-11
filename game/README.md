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

- `obj_player_explicacao` — tela usada em `rm_fase1_explicacao` e `rm_fase2_explicacao`, no layout do Figma: player de vídeo (play/pausa, voltar ao início, próximo, barra de progresso clicável, tempo, volume e tela cheia) e a caixa de legenda embaixo. Ao lado do player ficam os botões **Voltar** (esquerda; Fase 1 → `rm_nome`, Fase 2 → `rm_start_screen`; atalho Esc) e **Continuar** (direita; vai para o gameplay da fase; atalho Enter), feitos com a seta `spr_botao_seta` (espelhada no Continuar). O botão **próximo** do player também leva ao gameplay; quando o vídeo termina, o jogo segue sozinho. Espaço pausa/continua.
- `obj_tela_parabens` — tela de vitória (`rm_parabens`) no layout do Figma: quadro com "Parabéns!" e "Sua pontuação foi: …" (placar contando), voz e confetes, e os botões **Ver ranking** (`rm_leaderboard`) e **Voltar ao menu** (`rm_start_screen`), que falam o próprio nome quando o mouse passa por cima. Lê `global.pontuacao`.
- `scr_explicacao` — legendas dos vídeos (`legendas_fase1`, `legendas_fase2`, vazias até os vídeos ficarem prontos), fontes, ícones do player e funções de desenho.

**Como colocar os vídeos:** no GameMaker, adicione os arquivos em *Included Files* dentro de uma pasta `videos`, com os nomes `fase1_explicacao.mp4` e `fase2_explicacao.mp4`. Não precisa mudar código: a tela passa a tocar o vídeo sozinha. Para legendar, preencha `legendas_fase1()` / `legendas_fase2()` em `scr_explicacao` com os tempos (em ms) de cada fala do vídeo.

**Fontes:** as mesmas do Figma, Pixelify Sans e Press Start 2P (Google Fonts, licença OFL), ficam em *Included Files* (`datafiles/fonts/`) junto com as licenças.
