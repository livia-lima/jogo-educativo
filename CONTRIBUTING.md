# Guia de contribuição

## Regra principal

Este repositório existe para entregar um protótipo funcional até 12/11. Priorize tarefas P0 e não inicie funcionalidades extras sem acordo da equipe.

## Fluxo de trabalho

1. Consulte o quadro de tarefas e escolha uma tarefa com critério de aceite definido.
2. Atualize sua cópia da `main` antes de começar.
3. Crie uma branch curta a partir de `main`.
4. Faça alterações pequenas e testáveis.
5. Abra um Pull Request (PR), descrevendo o que foi feito, como foi testado e qualquer ponto pendente.
6. Peça revisão de pelo menos um desenvolvedor antes de integrar à `main`.

## Convenção de branches

```text
feat/nome-curto-da-tarefa
fix/descricao-do-problema
docs/assunto-da-documentacao
chore/manutencao
```

Exemplos: `feat/tela-inicial`, `fix/reinicio-da-atividade`, `docs/casos-de-teste`.

## Convenção de commits

Use mensagens curtas no imperativo:

```text
feat: cria fluxo da tela inicial
fix: impede interação após conclusão
docs: adiciona critérios de aceite do feedback
chore: configura estrutura inicial do projeto
```

## Checklist antes do PR

- [ ] A tarefa atende ao critério de aceite?
- [ ] O jogo abre e o fluxo afetado foi testado manualmente?
- [ ] Não foram adicionados arquivos de build, cache ou credenciais?
- [ ] Os assets têm origem/licença registrada quando aplicável?
- [ ] A descrição do PR informa como testar a mudança?

## Integração no GameMaker

- Evite duas pessoas alterarem o mesmo recurso GameMaker ao mesmo tempo.
- Avise no quadro de tarefas antes de editar uma room, objeto, script ou asset compartilhado.
- Faça uma cópia/backup antes de alterações estruturais no projeto.
- Gere uma build nos marcos definidos no planejamento; uma mudança só está integrada quando funciona na build.
