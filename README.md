# Jogo Educativo Inclusivo

> Protótipo de jogo educativo desenvolvido para apoiar a aprendizagem de estudantes com deficiência intelectual.

[![Status](https://img.shields.io/badge/status-em%20desenvolvimento-F2B705)](#status-do-projeto)
[![Disciplina](https://img.shields.io/badge/disciplina-Engenharia%20de%20Software-1F6FEB)](#contexto-acadêmico)
[![Motor](https://img.shields.io/badge/motor-GameMaker-000000)](https://gamemaker.io/)

## Sobre o projeto

Este é um projeto acadêmico da disciplina de Engenharia de Software. A equipe está transformando requisitos, casos de uso e protótipos previamente validados em uma experiência jogável, curta e acessível.

O protótipo prioriza um ciclo pedagógico claro: o estudante recebe uma instrução simples, realiza uma ação, recebe feedback imediato e pode continuar ou tentar novamente. As escolhas de interface buscam reduzir carga cognitiva e tornar a interação previsível.

> **Nota de escopo:** este repositório contém um protótipo acadêmico; ele não substitui acompanhamento pedagógico, avaliação clínica ou recursos de acessibilidade especializados.

## Objetivos

- Demonstrar uma mecânica educativa central de ponta a ponta.
- Aplicar práticas de Engenharia de Software: planejamento, versionamento, critérios de aceite, testes e entregas incrementais.
- Priorizar instruções objetivas, feedback de acerto/erro e navegação consistente.
- Entregar uma build demonstrável ao cliente em **12 de novembro de 2026**.

## Status do projeto

| Marco | Data | Situação |
|---|---:|---|
| Requisitos, casos de uso e prototipação | Concluído | ✅ Validado |
| Projeto-base e backlog do MVP | 25/10/2026 | ⏳ Planejado |
| Vertical slice jogável | 30/10/2026 | ⏳ Planejado |
| MVP completo | 06/11/2026 | ⏳ Planejado |
| Build candidata | 10/11/2026 | ⏳ Planejado |
| Entrega ao cliente | 12/11/2026 | ⏳ Planejado |

O cronograma detalhado está em [planejamentoImplementacao.md](planejamentoImplementacao.md).

## Funcionalidades do protótipo

### Incluídas no MVP

- Tela inicial e navegação até a atividade.
- Instrução curta, visual e/ou sonora.
- Mecânica educativa principal em uma atividade curta.
- Feedback imediato para acertos e erros.
- Estados de conclusão, falha e reinício.
- Interface legível, previsível e apropriada ao público-alvo.

### Fora desta entrega

- Múltiplas fases ou modos de jogo.
- Rankings, conquistas e personalização.
- Telemetria, analytics e efeitos visuais sofisticados.

## Tecnologias

- **GameMaker** — motor do jogo.
- **GML** — linguagem das mecânicas e da interface.
- **Git e GitHub** — versionamento, colaboração e histórico do projeto.

> A versão exata do GameMaker será registrada em `game/README.md` assim que o projeto for criado pela equipe.

## Estrutura do repositório

```text
.
├── assets/                    # Arquivos-fonte que não pertencem diretamente ao GameMaker
│   ├── audio/                 # Sons e narrações originais
│   ├── exportados/            # Assets prontos para importar no jogo
│   ├── fontes/                # Arquivos de tipografia licenciados
│   └── fonte/                 # Arquivos editáveis de design
├── docs/                      # Documentação da disciplina e do produto
│   ├── arquitetura/           # Decisões técnicas
│   ├── assets/                # Inventário e licenças de assets
│   ├── apresentacao/          # Roteiro da demonstração
│   └── testes/                # Casos de teste e evidências
├── game/                      # Projeto GameMaker (.yyp e recursos gerados pelo motor)
├── releases/                  # Builds locais; não versionadas
├── tests/                     # Cenários de teste e regressão
├── CONTRIBUTING.md            # Fluxo de colaboração da equipe
└── planejamentoImplementacao.md
```

Veja [docs/ESTRUTURA_PROJETO.md](docs/ESTRUTURA_PROJETO.md) para saber onde colocar cada arquivo e como iniciar o projeto GameMaker.

## Como executar

O jogo ainda está na etapa de estruturação. Após a primeira versão jogável:

1. Instale a versão do GameMaker registrada em `game/README.md`.
2. Clone este repositório.
3. Abra o arquivo `.yyp` dentro de `game/` pelo GameMaker.
4. Execute com `F6` ou use a build disponível na área de *Releases*.

## Acessibilidade e princípios de design

As decisões de implementação são guiadas pelo material de requisitos aprovado e por estes princípios:

- linguagem simples e uma ação principal por vez;
- feedback imediato e inequívoco;
- botões com área de toque confortável e rótulos claros;
- contraste, hierarquia visual e consistência entre telas;
- não depender exclusivamente de cor para comunicar estados;
- possibilidade de repetir instruções e reiniciar a atividade.

Esses princípios serão validados no ciclo de testes do protótipo; melhorias posteriores dependerão da validação com os públicos envolvidos.

## Equipe

| Área | Responsabilidade |
|---|---|
| Design | Assets, consistência visual e validação de legibilidade. |
| Regras de negócio | Critérios de aceite, validação funcional e testes. |
| Desenvolvimento | Arquitetura, mecânica central, interface, integração e builds. |

Os nomes e links dos integrantes serão adicionados quando a equipe autorizar a publicação.

## Contexto acadêmico

Projeto desenvolvido como critério de avaliação da disciplina de **Engenharia de Software**. A documentação preserva as decisões tomadas, os critérios de aceite e as evidências de teste para demonstrar o processo de desenvolvimento, não apenas o resultado final.

## Roadmap curto

- [ ] Criar o projeto GameMaker em `game/`.
- [ ] Converter os requisitos validados em tarefas P0 com critérios de aceite.
- [ ] Entregar o vertical slice em 30/10.
- [ ] Completar o MVP em 06/11.
- [ ] Testar e preparar a demonstração final até 11/11.

## Licença

Licença pendente de definição pela equipe. Antes de tornar o repositório público, confirmar que todos os assets, áudios, fontes e materiais de terceiros possuem licença compatível com a publicação.

---

Feito com foco em aprendizagem, inclusão e engenharia de software responsável.
