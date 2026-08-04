---
name: explain-it-to-me
description: Documents and explains every new technical concept that comes up while working, writing linked markdown notes into a personal Obsidian vault. Use ALWAYS after generating or changing code, choosing a library, applying an architecture pattern, or using any technical term that has no note in the vault yet. Also use when the person says "I don't get it", "what is this", "explain this to me", "why did you do it this way", or the equivalent in their own language ("não entendi", "o que é isso", "me explica", "por que você fez assim"). When unsure whether something is worth documenting, document it.
---

# Explain it to me

The goal is narrow: the person must not end a working session with code they cannot maintain.

A concept that slips by today becomes a blocker three weeks from now, when they need to change that code alone. Documenting is what turns "the AI did it" into "I know what I have".

## Who the reader is

Write for someone who has never worked in technology and needs this to get their own work done. **That baseline never moves.**

`profile.md` at the vault root refines it, and you read it before writing anything. It says what they already know so you stop explaining it, what is not their territory, which everyday analogies land best, and the language for notes.

If `profile.md` is missing, or still full of `{{placeholders}}`, the note must come out exactly as clear. Only the analogy becomes more general. An empty profile is never a reason for a harder note.

## Where the vault lives

Read `VAULT_PATH` from the project `.env`, or use `~/tech-vault/`.

```
tech-vault/
├── profile.md         who the reader is, read before writing
├── index.md           general map, updated with every new note
├── concepts/          one note per concept
└── projects/          one note per project, listing what it uses
```

If the folder does not exist, create it and say so in the chat.

## When to fire

Fire at the end of any delivery, without being asked:

- Code generated or changed that introduces a new concept, pattern, library or command
- An error you fixed (the cause becomes a note, not just the fix)
- An architecture decision, however small
- A technical term you used in the chat and did not explain at the time

Fire on demand too, whenever they ask what something is.

## The flow

1. **List the concepts** that came up. Be generous: `useEffect`, `debounce`, `environment variable`, `composite index`, `server component`, `migration` are all valid candidates. Skip only what is genuinely trivial (`if`, `for`, a variable name).

2. **Check the vault.** For each concept, look for `concepts/<slug>.md`. The slug is kebab-case with no accents, in the same language as the note, so a Portuguese vault holds `variavel-de-ambiente.md` and an English one holds `environment-variable.md`.

3. **If it does not exist, draft it** using `assets/note-template.md`, then run the critique pass below before saving.

4. **If it already exists, NEVER overwrite it.** Read the note, add one new line under "Where it is", and stop there. The "My notes" section belongs to them: preserve it byte for byte, even if empty, even if it contains something that looks wrong.

   **One exception, the empty stub.** Clicking a pending link in Obsidian's graph creates the file immediately, with nothing in it, and by default at the vault root rather than in `concepts/`. A file with no content is not a note anyone wrote, so fill it from the template and move it into `concepts/`. One line of their own text is enough to make it a real note, and then this exception no longer applies.

5. **Update `index.md`** with the new concept, grouped by theme.

6. **Update the project note** in `projects/<name>.md`, listing the concepts it uses.

7. **Summarise in the chat**, in 5 lines or fewer: what was built, which notes you created, and the one thing they need to know to change it alone later.

## Selection mode

When they ask for a specific term, with `/explain <term>` or with a snippet selected in the editor, document **only that**. Do not sweep the project, do not create context notes they did not ask for.

- **Named term:** follow the normal flow for that single concept.
- **Selected code with no term:** identify the central concept in the snippet, say which one you picked, and document it. If more than one strong candidate exists, ask before writing.
- **Note already exists:** do not recreate it. Show its content in the chat and ask what is missing. Their answer becomes an addition, and the addition goes under "My notes" in their words, not yours.

## Review mode

When they ask for `/review`, the point is not for you to explain again. It is for them to recall the concept from memory, because rereading the AI's note transfers nothing and rewriting it in their own words does.

1. List the notes in `concepts/` with `confidence: not-reviewed` in the frontmatter. If there are many, take the 3 oldest.
2. For each one, ask **one** open question and do not show the note: "what is `debounce`, in your own words?"
3. Wait for their answer. Only then show the note and point out the gap between the two versions, if there is one.
4. Write **their** answer under "My notes". This is the only circumstance in which you touch that section, and even here you use their words, not a rewrite of them.
5. Change `confidence` to `reviewed` in the frontmatter.

If they cannot answer, do not mark it reviewed. Explain from a different angle, with an analogy other than the one in the note, and leave it for the next round.

## How to write the note

The rule that governs everything else: **the reader must finish able to do the thing, not impressed.**

Bad explanation is worse than none, because they will reread it in a month and still be lost. Bad teaching writing fails in a particular way: it produces the sensation of having understood, and the person only discovers otherwise when they try to use it.

### Open with the plain sentence

The first sentence of "What it is" says the simplest true thing, in fewer than fifteen words, with no second clause. "A vault is a folder." Then stop. Build the rest after it.

Detail arriving in the same breath as the definition buries the definition. If your first sentence carries a comma and a "which", it is not the plain sentence yet.

### One new term at a time

Count the technical terms in each paragraph that the reader has not met yet. The budget is one.

If a second is needed, split the paragraph, or give that term its own note and a `[[wikilink]]`. Words that look ordinary and still count: index, database, repository, dependency, environment, instance, render, build.

### The four rules of definition

**Cascading jargon.** If the definition of a concept uses another technical term, you have two options and no third. Either explain that term right there in parentheses, or create its note too and link it with a `[[wikilink]]`. Never leave an unexplained term inside an explanation.

**Concrete analogy.** One per note, drawn from ordinary life that anyone has lived: drawers and folders, a queue at a counter, a recipe, post-its on a wall, sending a letter, a shopping list, setting a table.

Never build the analogy out of software, tooling or a developer's workflow, even when the concept itself is about software. "It is like opening a project in your editor" asks the reader to already understand the thing being explained. Four further constraints:

- It comes from what the reader already commands. An analogy that needs explaining has become a second subject to learn.
- One per concept. Stacked analogies make the reader spend attention comparing the comparisons.
- Cut test: delete the analogy. If the explanation is still complete, the analogy was decoration.
- Say where it breaks. Every analogy has a limit and the reader will hit it alone. Naming the limit stops them from generalising wrongly.

**Size.** The answer to "what is it" fits in two or three sentences. If it does not fit, the concept is too big and should become two notes.

**Local why.** They need to know why this concept exists in THEIR project, not the textbook definition. "It is used for X" is weak. "It is here because without it the page would reload on every keystroke" is strong.

### Open the note with a scene, not a rationale

"The problem it solved here" is a moment that happened, told in the second person: what they were doing, what went wrong or would have gone wrong. A list of design requirements is not a scene, and three requirements in one sentence is the most common version of this failure.

### At the hardest point, a worked example rather than an image

At the peak of difficulty the reader needs to see the thing happening step by step, with real code or real numbers from their own project. Reaching for a figure of speech exactly where they most need solid ground is the classic failure.

### Name the common error

Saying where people get this wrong is worth more than one more explanation of the right way, because it hands the reader a way to check themselves.

### Active verification

Close the note with something that requires the reader to produce, not to recognise. A question answered with "yes" verifies nothing. Put the answer in a collapsed block so they can check themselves afterwards.

### Cut what only you find interesting

System paths they will never open, internals that do not change what they can do, background that shows off. Every line earns its place by helping them act. A list of six locations where two matter is five lines of noise and one of signal.

### Cognitive load

If a paragraph asks the reader to hold three things at once, it becomes a table, a list, or two paragraphs.

### Language filter

Avoid these four, which show up in teaching writing more than anywhere else:

- **Pointing at the insight.** "Note that", "notice how", "observe that", "this is exactly why". If the next sentence is the insight, it stands on its own.
- **Serial contrast.** "It is not about memorising, it is about understanding." One per note at most, then plain statements.
- **Intelligence pose.** A hard word where a simple one works, decorative triads, dramatic colons. Every opaque word is a reader who stopped reading.
- **Formulaic text.** If every note has the identical rhythm, it becomes predictable noise and the reader starts skipping blocks.

Also banned: em dashes, staccato of the "Not X. Y." kind, and more than two lines written for effect in a single note.

## The critique pass, before you save

Never write the file straight from the draft. This is the step that separates a correct note from a useful one, and it is the one that gets skipped.

Reread the draft as the learner rather than the author, and check four channels:

| Channel | Question | Typical failure |
|---|---|---|
| Comprehension | Can it be followed without rereading? | A hidden step, a leap, a term used before it was defined |
| Retention | Will it stick once the file is closed? | Facts with no structure and nothing to do |
| Transfer | Could they apply it to a case you did not show? | Only the canonical example, which teaches the example |
| Flow | Does the reading carry to the end? | Constant density, no breathing room, no example |

Then run three mechanical checks on the draft:

1. Read the first sentence of "What it is" alone. Does it stand by itself and stay under fifteen words?
2. Underline every technical term. Is any paragraph carrying more than one that is new to the reader?
3. Delete the analogy and reread. If nothing is lost, the analogy was decoration and needs replacing.

Fix what the pass finds, then save. A pass that finds nothing means it was read as the author.

## Note format

Follow `assets/note-template.md`.

**Frontmatter keys stay in English** in every vault, whatever the note language, so that graph filters and search work the same everywhere: `type`, `created`, `projects`, `confidence`.

**Prose and section headings go in the reader's language**, taken from `profile.md`, defaulting to the language they write to you in. Keep the technical term itself in its original form, because that is what appears on the buttons they click and what they would type into a search. Explain in their language, name in the original.

Once a vault has notes, match the headings already in use there so the vault stays consistent.

Wikilinks are what draw the web in Obsidian. Link generously: parent concept, sibling concepts, the project where it showed up. A link to a note that does not exist yet is good rather than broken: it marks the next concept to document.

## Example

**Context:** you have just added a `debounce` to a search field.

Note created at `concepts/debounce.md`:

> ## The problem it solved here
> You typed "candle" into the search box and the page crawled. Every single letter had sent its own question to the database, so six letters meant six questions where one would have done.
>
> ## What it is
> A debounce is a wait.
>
> It holds an action back until the person has stopped for a moment. Type again before the wait is over and the clock starts from zero.
>
> ## Analogy
> The lift that keeps its doors open a few seconds before closing. Every new person stepping in restarts the count.
>
> **Where the analogy breaks:** the lift closes eventually no matter what. A debounce waits forever if the typing never stops.
>
> ## Test yourself
> The wait is set to 300ms. Someone types 5 letters, one every 200ms. How many questions reach the database?
>
> <details><summary>answer</summary>One. Each letter restarts the clock, and 200ms is shorter than 300ms, so only the pause after the last letter is long enough to finish.</details>

**Chat summary:**

> Added a 300ms debounce to the search (`src/components/Search.tsx`, line 24). Created 2 notes: [[debounce]] and [[input-event]]. If the search ever feels slow to respond, 300 is the number to change.

## What not to do

- Do not ask "want me to document this?" first. Document, then say so.
- Do not create a note for a concept already in the vault just because your definition is simpler than the one there.
- Do not write in the register of official documentation. Write as someone explaining to a smart colleague who has never worked in technology.
- Do not touch "My notes", with the single exception of review mode, where you transcribe their words.
