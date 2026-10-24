# 🌱 Jogo Educativo – Consciência Ambiental (ASSARTE)

> **Problema:** alunos da ASSARTE têm dificuldade em relacionar coisas (palavra × imagem, número × quantidade) e em perceber que há tecnologia além da sala de informática.
> **Resultado:** um jogo educativo de duas fases, com feedback sonoro, ranking lúdico e relatório de desempenho para a professora.
> **Stack:** Figma (interface), IA generativa (ilustrações), Coolors (paleta de cores) e dublagem em áudio.
> **Objetivo:** desenvolver as habilidades de associação e contagem por meio de elementos de sustentabilidade do cotidiano.

---

## 📖 Sobre o projeto

Projeto da disciplina de Engenharia de Software. A partir da visita técnica à ASSARTE, a professora apontou duas dificuldades principais dos alunos:

1. Manter-se atualizado (mostrar que existe tecnologia fora da sala de informática);
2. Relacionar coisas (palavra × imagem, número × quantidade).

O jogo transforma essas competências em atividades lúdicas. As fases podem ter mecânicas diferentes, mas todas giram em torno do **mesmo conjunto de elementos**.

## 📅 Datas

| Data  | Entrega                    |
|-------|----------------------------|
| 15/10 | Protótipo + caso de uso    |
| 12/11 | Entrega final              |

## 🎮 Fases

### Fase 1 – Palavra × Imagem
- **Objetivo pedagógico:** desenvolver a associação entre palavra e imagem.
- **Tarefa:** cartões divididos em duas colunas:
  - **Coluna A (imagens):** ilustrações grandes, coloridas e de alto contraste.
  - **Coluna B (palavras-chave):** caixas de texto curtas, em fonte bastão grande.
- **Mecânica:** arrastar a palavra até a imagem (*drag and drop*) ou clicar na palavra e depois na imagem correspondente.
- **Acessibilidade:** feedback sonoro positivo e imediato, com animação suave e ganho de pontos/moedas. Em caso de erro, o item retorna suavemente, **sem penalidades punitivas**.

### Fase 2 – Número × Quantidade
- **Objetivo pedagógico:** desenvolver a associação entre contagem concreta e quantidade de elementos.
- **Mecânica:**
  - O jogo exibe uma quantidade de um item na cena (ex.: 3 garrafas reutilizáveis ou 2 bicicletas);
  - Na lateral, aparecem opções de números grandes;
  - O aluno conta os elementos e escolhe o numeral correspondente.
- **Acessibilidade:** ao passar o mouse ou tocar em cada elemento, a interface conta em voz alta (1… 2… 3…).

## 🧩 Elementos do jogo

Pares de contraste (sustentável × não sustentável):

| # | Elemento                                   | Associação visual                                                        |
|---|--------------------------------------------|--------------------------------------------------------------------------|
| 1 | Garrafa reutilizável × Garrafa descartável | Garrafa colorida para levar à escola × lixo plástico amassado no chão    |
| 2 | Sacola retornável × Sacola plástica        | Ecobag de feira com desenho de fruta × saquinho plástico voando/rasgado  |
| 3 | Bicicleta × Carro soltando fumaça          | Transporte limpo de duas rodas × carro com escapamento soltando fumaça   |
| 4 | Lixeira de coleta seletiva × Lixo no chão  | Lixeira organizada e colorida × bagunça de lixo espalhado na rua         |
| 5 | Torneira fechada × Torneira aberta         | Economia × água sendo derramada                                          |
| 6 | Árvores (parques) × Prédios                | Parques verdes e coloridos × prédios de cores opacas                     |

### Cenários (Ponta Grossa – PR)
- Lago Olarias
- UTFPR – Ponta Grossa
- Chácara Colégio Santana
- Igreja São José
- Parque Monteiro Lobato

### 🎨 Paletas de cores
- [Paleta principal (verdes e azuis)](https://coolors.co/palette/d9ed92-b5e48c-99d98c-76c893-52b69a-34a0a4-168aad-1a759f-1e6091-184e77)
- [Paleta de apoio](https://coolors.co/palette/f94144-f3722c-f8961e-f9844a-f9c74f-90be6d-43aa8b-4d908e-577590-277da1)
- [Paleta para os objetos das atividades](https://coolors.co/palette/ff0000-ff8700-ffd300-deff0a-a1ff0a-0aff99-0aefff-147df5-580aff-be0aff)
- [Paleta de tons terrosos](https://coolors.co/palette/582f0e-7f4f24-936639-a68a64-b6ad90-c2c5aa-a4ac86-656d4a-414833-333d29)

## 🖥️ Interface (Figma)

- **Tela 1 – Início:** botão de iniciar, botão de relatório (leva à tela de relatórios) e troféu de ranking.
- **Tela 2 – Fase 1**
- **Tela 3 – Fase 2**

## 🏆 Ranking e relatório

**Ranking**
- Pontuação baseada em tempo de resposta e acertos (fórmula a definir).
- Apresentação lúdica para prender a atenção dos alunos.

**Relatório**
- Timer em segundo plano que registra o momento de cada acerto/erro.
- Permite à professora avaliar o tempo de reação de cada aluno.

## ✅ Requisitos

- [ ] Dublagem (voz para palavras, feedbacks e contagem)
- [ ] Relatório de desempenho para a professora
- [ ] Ranking com pontuação por tempo e acertos
- [ ] Feedback sonoro e animações positivas
- [ ] Interface acessível (fontes grandes, alto contraste)

## 🛠️ Stack

| Área                     | Ferramenta                    |
|--------------------------|-------------------------------|
| Design da interface      | Figma                         |
| Geração de ilustrações   | IA generativa                 |
| Paleta de cores          | Coolors                       |
| Áudio                    | Dublagem                      |
| Implementação do jogo    | _A definir_                   |

## 👥 Equipe

| Integrante | Responsabilidade                            |
|------------|---------------------------------------------|
| João       | Elementos do jogo (gerados com IA)          |
| Marcones   | Elementos da interface (Figma)              |
| _..._      | _..._                                       |

## 📄 Licença

_A definir._