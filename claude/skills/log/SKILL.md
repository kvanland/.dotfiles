---
name: log
description: Document life events in the Obsidian vault. Use when the user wants to create trip notes, daily notes, event notes, journal entries, or any personal life documentation. Invoke when asked to "log", "document", "record", "write up", or "create a note" about something that happened.
allowed-tools: Write, Read, Glob, AskUserQuestion, Bash(date *)
argument-hint: [note title]
---

# Life Event Logger

Your job is to create a new Obsidian note in `/Users/kvanland/ObsidianNotes/` by selecting a template and filling it in with information gathered from the user.

## Step 1: Discover available templates

Use the `Glob` tool to list all templates:
- Pattern: `Meta/Templates/*.md`
- Path: `/Users/kvanland/ObsidianNotes`

## Step 2: Ask the user which template to use

Use `AskUserQuestion` to present the list of discovered templates and ask the user to pick one. Show only the template name (strip " Template" suffix and ".md" extension for display, e.g. "Trip Template.md" → "Trip").

## Step 3: Read the chosen template

Use the `Read` tool to read the full contents of the selected template file from `/Users/kvanland/ObsidianNotes/Meta/Templates/<Template Name>.md`.

## Step 4: Ask the user for the note title and content

Use `AskUserQuestion` to ask:
1. **Note title** — what should the file be named? (without `.md`)
2. **Content** — what happened / what should go in the note? Ask for all information needed to fill in the template's fields. Look at the template's frontmatter fields and body to determine what to ask.

For any `{{date}}` placeholder in the template, substitute today's date in `YYYY-MM-DD` format.
For any `{{time}}` placeholder, substitute the current time.

## Step 5: Write the note

Use the `Write` tool to create the file at:
`/Users/kvanland/ObsidianNotes/<Note Title>.md`

Fill in the template exactly — preserve all frontmatter keys, structure, and body content from the template. Only replace `{{date}}` / `{{time}}` placeholders and populate the fields with the user's information.

Apply these Obsidian conventions when filling in content:
- People's names → `[[Full Name]]` wikilinks
- Locations → `[[Location Name]]` wikilinks
- Dates in frontmatter → ISO 8601 format (`YYYY-MM-DD` or `YYYY-MM-DDTHH:MM:SS`)
- Tags → lowercase with hyphens
- If a field has no value, leave it blank (keep the key, empty value)

After writing the file, confirm the file path to the user.
