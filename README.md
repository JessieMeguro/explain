# explica-pra-mim

Uma skill para quem constrói com AI e não quer terminar a sessão com código funcionando que não sabe manter.

Cada vez que o agente gera código, escolhe uma biblioteca ou aplica um padrão, ele grava uma nota explicando **o que é**, **por que apareceu no seu projeto** e **o que cuidar se você mexer**. As notas ficam num vault do Obsidian, ligadas por wikilinks. Com o tempo isso deixa de ser um arquivo de notas e vira um caderno vivo do que você já entendeu.

## Para quem é

Pessoas que leem código e entendem lógica, mas para quem o vocabulário de infraestrutura, padrões de arquitetura e ecossistema de bibliotecas ainda não é familiar. Designers, gerentes de produto, gente migrando de área, quem está aprendendo.

O problema que isso resolve não é escrever código. É que o conceito que passa despercebido hoje vira um bloqueio daqui a três semanas.

## Instalação

```bash
curl -fsSL https://raw.githubusercontent.com/JessieMeguro/obsidian/main/install.sh | bash
```

Ou clonando, se preferir ler antes de rodar:

```bash
git clone https://github.com/JessieMeguro/obsidian.git
cd obsidian && ./install.sh
```

O instalador cria o vault em `~/vault-tecnico/` e copia a skill para `~/.cursor/skills/` e `~/.claude/skills/`. É seguro rodar de novo para atualizar: `perfil.md` e suas notas nunca são sobrescritos.

Para usar outro caminho de vault: `VAULT_PATH=~/meu-vault ./install.sh`.

Depois de instalar, **reinicie o Cursor** e edite `~/vault-tecnico/perfil.md`.

## O perfil

`perfil.md` é o que faz a diferença entre uma nota genérica e uma que você entende. Nele você declara sua profissão, o que já domina (e a skill não precisa explicar), o que não é seu território, e o repertório de analogias que funciona com você — design, cozinha, e-commerce, dinâmica de time.

Ele mora no vault e não na pasta da skill, justamente para sobreviver a qualquer atualização.

## Como usar

A skill dispara sozinha ao fim de cada entrega. Você não precisa pedir.

| Comando | O que faz |
|---|---|
| `/explica <termo>` | Documenta só aquele conceito |
| código selecionado + a skill | Documenta o conceito central do trecho |
| `/revisar` | Puxa as notas não revisadas e te faz a pergunta de volta |

## O vault

```
vault-tecnico/
├── perfil.md          quem você é
├── indice.md          mapa geral por tema
├── conceitos/         uma nota por conceito
└── projetos/          uma nota por projeto
```

Um vault único, fora dos projetos. É o que faz o conceito aprendido num projeto reaparecer linkado quando surgir em outro.

Cada nota tem `confianca: nao-revisado` no frontmatter até você revisar, e uma seção **Minhas notas** que a AI não escreve. Esse espaço é seu.

## Ligar o Obsidian

1. Baixe o [Obsidian](https://obsidian.md) (gratuito, tudo local).
2. "Open folder as vault" e aponte para `~/vault-tecnico/`.
3. Abra a visão de grafo no ícone da lateral esquerda.

Os `[[wikilinks]]` que a skill escreve viram as linhas da teia sozinhos.

Ajustes que valem a pena no grafo:

- Ative **Show orphans** para achar conceitos que ficaram soltos, sem conexão. Costuma ser sinal de nota mal escrita.
- Desligue **Existing files only** para ver os links pendentes, ou seja, os conceitos que a skill mencionou mas ainda não documentou. É sua fila de estudo.
- Em **Groups**, crie um filtro `confianca:nao-revisado` numa cor forte. Assim o grafo mostra visualmente o que você ainda não leu com calma.

Alternativa sem sair do editor: a extensão **Foam** faz grafo e wikilinks dentro do próprio Cursor, lendo a mesma pasta.

## O ritual que faz isso funcionar

A skill resolve a captura. O que ela não resolve sozinha é a revisão.

Uma vez por semana, rode `/revisar`. Ela vai te perguntar o que um conceito é, sem mostrar a nota, e só marca como revisado depois que você responder com suas palavras.

O ato de reescrever com as próprias palavras é o que transfere o conceito. Ler a nota da AI de novo não transfere nada.

## Estrutura deste repositório

```
├── install.sh
├── skills/explica-pra-mim/
│   ├── SKILL.md
│   └── assets/
│       ├── template-nota.md
│       └── template-perfil.md
└── vault-template/
    └── indice.md
```

Este repositório guarda só a skill. Seu vault de notas é local e não passa por aqui.
