# explain-it-to-me

A skill that makes your coding agent explain what it just built, and file the explanation in an Obsidian vault you can grow.

## The problem this solves

You ask an agent for a feature. It works. Three weeks later you open the file and find a `useMemo`, a database migration and an environment variable you have never seen before. Nothing is broken, so nothing warned you. You cannot safely change any of it, so you ask the agent again, and the gap between what you own and what you understand gets a little wider.

That gap is the target here. Not the code, which was fine.

## What it does

At the end of every delivery, the agent writes one note per new concept into a local vault. Each note answers four things:

| Section | What it holds |
|---|---|
| The problem it solved here | The concrete thing that was breaking in *your* project |
| What it is | Two or three sentences, no unexplained jargon |
| Analogy | One comparison drawn from a repertoire you define, plus where that comparison stops working |
| If I need to change it | The main risk, the common mistake, and what is safe to adjust |

Notes link to each other with `[[wikilinks]]`, so Obsidian draws the connections for you. Every note also ends with a question you have to answer, and a section the AI is forbidden from writing in.

## Who it is for

People who read code and follow logic, but for whom infrastructure vocabulary, architecture patterns and library names are still unfamiliar territory. Designers, product managers, people switching fields, anyone learning by building.

## Before you install

You need a coding agent (Cursor or Claude Code), `git`, and [Obsidian](https://obsidian.md), which is free and keeps everything on your machine.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/JessieMeguro/explain/main/install.sh | bash
```

Or clone first, if you would rather read the script before running it:

```bash
git clone https://github.com/JessieMeguro/explain.git
cd explain && ./install.sh
```

The installer creates a vault at `~/tech-vault/` and copies the skill into `~/.cursor/skills/` and `~/.claude/skills/`. Running it again is safe and is how you update: your notes and your `profile.md` are never overwritten.

For a different vault location, set `VAULT_PATH=~/my-vault ./install.sh`.

Two things to do afterwards: restart your agent so it loads the skill, and fill in `~/tech-vault/profile.md`.

## The profile is not optional

`profile.md` is the difference between a note you understand and a note that reads like a manual. In it you declare your profession, what you already know (so the skill stops explaining it), what is not your territory, and the worlds your analogies should come from: design handoffs, team dynamics, cooking, shop windows, whatever actually works on you.

It lives in the vault rather than in the skill folder, which is what lets it survive every update.

## Using it

The skill fires on its own after each delivery. You do not have to ask.

| Command | What happens |
|---|---|
| `/explain <term>` | Documents that one concept and nothing else |
| Select code, then invoke the skill | Documents the central concept in the selection |
| `/review` | Asks you what a concept is, without showing you the note |

## The vault

```
tech-vault/
├── profile.md         who you are
├── index.md           general map, by theme
├── concepts/          one note per concept
└── projects/          one note per project
```

One vault, kept outside your projects. That is what makes a concept you learned in one project show up already linked when it appears in the next one.

Frontmatter keys are always English (`type`, `created`, `projects`, `confidence`) so search and graph filters behave the same in any vault. The prose is written in whatever language you set in your profile, and note filenames follow that language too.

## Setting up the graph

Open Obsidian, choose "Open folder as vault", point it at `~/tech-vault/`, and open the graph from the left sidebar. Three settings pay for themselves:

- **Show orphans** reveals concepts that ended up with no connections, which usually means the note was written poorly.
- Turning **Existing files only** off shows pending links, the concepts the skill mentioned but has not documented yet. That is your reading queue.
- Under **Groups**, add a filter for `confidence:not-reviewed` in a strong colour, so the graph shows you at a glance what you have not sat with yet.

If you would rather not leave your editor, the **Foam** extension renders graphs and wikilinks inside Cursor from the same folder.

## The weekly ritual

Capture is the part the skill handles. Recall is the part it cannot do for you.

Once a week, run `/review`. It picks the notes you have not reviewed, asks what one of them means without showing you the answer, and only marks it reviewed once you have written your version under "My notes". Rewriting a concept in your own words is what moves it into your head. Rereading the AI's paragraph does not.

## Where people get this wrong

- **Treating the vault as documentation.** It is a study tool. Notes you never answer back to are an archive, not knowledge.
- **Leaving `profile.md` empty** and then wondering why the analogies feel generic. The skill falls back to a sensible default, and a default is all it can be.
- **Skipping the review.** This is the failure that matters. A vault of 200 unreviewed notes feels like progress and teaches you nothing.

## What is in this repository

```
├── install.sh
├── skills/explain-it-to-me/
│   ├── SKILL.md
│   └── assets/
│       ├── note-template.md
│       └── profile-template.md
└── vault-template/
    └── index.md
```

Only the skill lives here. Your vault, your profile and your notes stay on your machine and never pass through this repository.
