---
name: explica-pra-mim
description: Documenta e explica todo conceito técnico novo que aparecer no trabalho, gravando notas markdown interligadas num vault pessoal do Obsidian. Use SEMPRE que gerar ou modificar código, escolher uma biblioteca, aplicar um padrão de arquitetura, ou usar qualquer termo técnico sem nota no vault. Use também quando a pessoa disser "não entendi", "o que é isso", "me explica", "por que você fez assim", ou quando pedir para revisar algo que ela mesma gerou antes. Na dúvida sobre se vale documentar, documente.
---

# Explica pra mim

O objetivo desta skill é simples: a pessoa não deve terminar uma sessão de trabalho com código funcionando que ela não sabe manter.

Cada conceito que passa despercebido hoje vira um bloqueio daqui a três semanas, quando ela precisar mexer sozinha no que foi criado. Documentar é o que transforma "a AI fez" em "eu sei o que tenho".

## Quem é a pessoa

Leia `perfil.md` na raiz do vault antes de escrever qualquer nota. Ele declara a profissão dela, o que ela já domina, o que não é o território dela, e o repertório de analogias que funciona.

Se `perfil.md` não existir, assuma o padrão: **alguém que lê código e entende lógica, mas para quem o vocabulário de infraestrutura, padrões de arquitetura e ecossistema de bibliotecas não é familiar.** Use analogias do cotidiano e de processos de trabalho.

## Onde fica o vault

Leia `VAULT_PATH` do arquivo `.env` do projeto, ou use `~/vault-tecnico/` como padrão.

Estrutura:

```
vault-tecnico/
├── perfil.md          (quem é a pessoa, lido antes de escrever)
├── indice.md          (mapa geral, atualizado a cada nota nova)
├── conceitos/         (uma nota por conceito)
└── projetos/          (uma nota por projeto, listando o que ele usa)
```

Se a pasta não existir, crie e avise no chat.

## Quando disparar

Dispare ao final de qualquer entrega, sem esperar ser perguntada:

- Código gerado ou alterado que introduz conceito, padrão, biblioteca ou comando novo
- Erro que você resolveu (a causa vira nota, não só a correção)
- Decisão de arquitetura, mesmo pequena
- Termo técnico que você usou no chat e não explicou na hora

Dispare também sob demanda, quando ela perguntar o que algo é.

## O fluxo

1. **Liste os conceitos** que apareceram. Seja generosa: `useEffect`, `debounce`, `variável de ambiente`, `índice composto`, `server component`, `migration` são todos candidatos válidos. Ignore só o que for trivial de verdade (`if`, `for`, nome de variável).

2. **Cheque o vault.** Para cada conceito, procure `conceitos/<slug>.md`. O slug é kebab-case sem acento: `variavel-de-ambiente.md`, `server-component.md`.

3. **Se não existe, crie** usando o template em `assets/template-nota.md`.

4. **Se já existe, NUNCA sobrescreva.** Leia a nota, adicione uma linha nova em "Onde está" e pare por aí. A seção "Minhas notas" é território dela: preserve byte a byte, mesmo que esteja vazia, mesmo que tenha algo que pareça errado.

5. **Atualize `indice.md`** com o conceito novo, agrupado por tema.

6. **Atualize a nota do projeto** em `projetos/<nome>.md`, listando os conceitos que ele usa.

7. **Resuma no chat**, em no máximo 5 linhas: o que foi construído, quais notas você criou, e a única coisa que ela precisa saber para mexer nisso sozinha depois.

## Modo seleção

Quando ela pedir explicitamente por um termo, com `/explica <termo>` ou com um trecho de código selecionado no editor, documente **apenas aquilo**. Não varra o projeto inteiro, não crie notas de contexto que ela não pediu.

- **Termo nomeado:** siga o fluxo normal para esse único conceito.
- **Código selecionado sem termo:** identifique o conceito central do trecho, diga qual você escolheu, e documente esse. Se houver mais de um candidato forte, pergunte antes de escrever.
- **Nota já existe:** não recrie. Mostre o conteúdo dela no chat e pergunte o que ficou faltando. A resposta dela vira acréscimo, e o acréscimo vai em "Minhas notas" com as palavras dela, não com as suas.

## Modo revisão

Quando ela pedir `/revisar`, o objetivo não é você explicar de novo. É ela recuperar o conceito de memória, porque reler a nota da AI não transfere nada e reescrever com as próprias palavras transfere.

1. Liste as notas de `conceitos/` com `confianca: nao-revisado` no frontmatter. Se houver muitas, pegue as 3 mais antigas.
2. Para cada uma, faça **uma** pergunta aberta e não mostre a nota: "o que é `debounce`, com suas palavras?"
3. Espere a resposta dela. Só então mostre a nota e aponte a diferença entre as duas versões, se houver.
4. Escreva a resposta **dela** em "Minhas notas" — é a única circunstância em que você toca nessa seção, e ainda assim usando as palavras dela, não uma reescrita sua.
5. Mude `confianca` para `revisado` no frontmatter.

Se ela não souber responder, não marque como revisado. Explique de outro ângulo, com uma analogia diferente da que está na nota, e deixe para a próxima rodada.

## Como escrever a definição

Esta é a parte que faz a skill valer alguma coisa. Uma definição ruim é pior que nenhuma, porque ela vai reler daqui a um mês e continuar perdida.

**Regra do jargão em cascata:** se a definição de um conceito usa outro termo técnico, você tem duas opções e nenhuma terceira. Ou explica o termo ali mesmo entre parênteses, ou cria a nota dele também e linka com `[[wikilink]]`. Nunca deixe um termo não explicado dentro de uma explicação.

**Regra da analogia concreta:** toda nota tem uma analogia com algo do repertório declarado em `perfil.md`. Sem perfil, use cotidiano e processos de trabalho: cozinha, organização de arquivos, fila de atendimento, mudança de casa. Nada de "pense em uma fábrica de widgets".

**Regra do tamanho:** a resposta ao "o que é" cabe em duas ou três frases. Se não couber, o conceito está grande demais e deve virar duas notas.

**Regra do porquê:** ela precisa saber por que esse conceito existe no projeto DELA, não a definição de manual. "Serve para X" é fraco. "Está aqui porque sem isso a página recarregaria a cada tecla digitada" é forte.

## Formato da nota

Siga exatamente o template em `assets/template-nota.md`. Os campos que mais importam:

- `## O que é` em duas ou três frases
- `## Analogia`
- `## Por que apareceu aqui` com o problema concreto que resolveu
- `## Onde está` com caminho de arquivo e linha
- `## Se eu precisar mexer` com o cuidado principal e o erro mais comum
- `## Conectado a` com os `[[wikilinks]]`
- `## Minhas notas` sempre vazia na criação

Os wikilinks são o que desenha a teia no Obsidian. Linke com generosidade: conceito pai, conceitos irmãos, o projeto onde apareceu. Um link para uma nota que ainda não existe é bom, não é erro: ele marca o próximo conceito a documentar.

## Exemplo

**Contexto:** você acabou de adicionar um `debounce` num campo de busca.

**Nota criada** em `conceitos/debounce.md`:

> ## O que é
> Uma técnica para segurar uma função e só executar depois que a pessoa parar de agir por um tempinho. Se ela digitar de novo antes do prazo, o relógio zera.
>
> ## Analogia
> É o elevador que espera alguns segundos antes de fechar a porta. Cada pessoa nova que entra reinicia a contagem.
>
> ## Por que apareceu aqui
> Sem isso, o campo de busca dispararia uma consulta ao banco a cada tecla. "candle" viraria 6 consultas em vez de 1.

**Resumo no chat:**

> Adicionei debounce de 300ms na busca (`src/components/Search.tsx`, linha 24). Criei 2 notas: [[debounce]] e [[evento-de-input]]. Se a busca parecer lenta pra responder, o número a mexer é o 300.

## O que não fazer

- Não pergunte "quer que eu documente?" antes. Documente e avise depois.
- Não crie nota de conceito que já está no vault só porque a definição de lá está mais simples que a sua.
- Não escreva a nota em tom de documentação oficial. Escreva como quem explica pra uma colega esperta que não é da área.
- Não toque em "Minhas notas", com a única exceção do modo revisão, onde você transcreve as palavras dela.
