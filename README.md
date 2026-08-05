# explain-it-to-me

A skill that makes your coding agent explain what it just built, and file the explanation in an Obsidian vault you can grow.

## The problem this solves

AI-generated projects can contain libraries, configuration, and architecture decisions their owners have not learned yet. This skill records the concepts needed to understand and maintain that work.

## What it does

After work introduces a concept you need to understand or maintain, the agent writes a concise note into a local vault. It records the central concepts rather than every technical term.

| Section | What it holds |
|---|---|
| What it is | A short, technically correct definition |
| Where it appears here | The relevant file, behaviour, and practical effect |
| A specific change, such as "If you rename this note" | The relevant consequence or safe adjustment |

Examples, analogies, common mistakes, review questions, and related links are optional. They appear only when they make that particular concept easier to understand. Every note ends with a section reserved for your own words.

Change sections name exactly what is being changed. The skill does not use vague headings such as "If you change it".

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

## The profile

`profile.md` helps the skill avoid explaining what you already know and selects the language for your notes. Clear writing does not depend on a completed profile: when it is empty, the skill uses the language of the conversation and makes no personal assumptions.

It lives in the vault rather than in the skill folder, which is what lets it survive every update.

## Using it

The skill runs when a delivery introduces a concept you need to understand or maintain. You can also invoke it directly.

| Command | What happens |
|---|---|
| `/explain-it-to-me <term>` | Documents that one concept and nothing else |
| `/explain-it-to-me` with code selected | Documents the central concept in the selection |
| `/explain-it-to-me review` | Asks you what a concept is, without showing you the note |

The commands use the skill's own name on purpose. A shorter `/explain` would collide with a command most editors already define, and the two sets of instructions pull in opposite directions.

## The vault

```
tech-vault/
├── profile.md         optional language and writing preferences
├── index.md           general map, by theme
├── concepts/          one note per concept
└── projects/          one note per project
```

One vault, kept outside your projects. A concept documented for one project remains available when it appears in another.

Frontmatter keys are always English (`type`, `created`, `projects`, `confidence`) so search and graph filters behave the same in any vault. The prose is written in whatever language you set in your profile, and note filenames follow that language too.

## Privacy

The repository contains templates only. The installer creates the vault under your home directory, outside the cloned repository.

Your `profile.md`, concept notes, project notes, and Obsidian settings remain on your machine. The installer does not upload them and never overwrites an existing profile, index, or note. The included `.gitignore` also blocks common vault paths if personal files are accidentally created inside a clone.

## Setting up the graph

Open Obsidian, choose "Open folder as vault", point it at `~/tech-vault/`, and open the graph from the left sidebar. One useful setting is:

- Under **Groups**, add a filter for `confidence:not-reviewed` to distinguish notes that have not been reviewed.

If you create notes by clicking links in Obsidian, set **Settings, Files and links, Default location for new notes** to `concepts/`.

If you would rather not leave your editor, the **Foam** extension renders graphs and wikilinks inside Cursor from the same folder.

## The weekly ritual

Once a week, run `/explain-it-to-me review`. It selects notes you have not reviewed and asks you to explain one without showing its contents. Your answer is recorded under "My notes"; the status changes to reviewed when your answer contains the central idea.

## Where people get this wrong

- **Documenting every term.** Record the concepts required to understand or maintain the work.
- **Forcing every section into every note.** A simple concept should produce a short note.
- **Treating product behaviour as universal.** Settings and versions can change how a feature works.

## What is in this repository

```
├── .gitignore
├── LICENSE
├── README.md
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

## License

MIT. You may use, modify, and redistribute the skill while keeping the copyright and license notice.
