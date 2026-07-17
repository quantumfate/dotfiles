---
name: code-clarity
description: Write and refactor code that is explicit but clean — small concise comments, strong names, isolated scopes. Use whenever authoring or reviewing code, writing comments/docstrings, or when the user asks for cleaner, less verbose, more readable, or better-structured code. Applies to any language.
---

# Code Clarity

Goal: code a reader understands fast, without a wall of prose. Explanations exist to
carry what the code cannot; everything else is said by names and structure.

## Hard rules (enforced)

These are not suggestions. Apply them on every edit; a diff that violates one is not
finished.

1. **Documentation by code structure first.** The primary way to document is
   structure, not prose: name things well, extract scopes, split functions. Reach for
   a rename or an extraction before a comment. A comment is only allowed to carry what
   structure cannot.
2. **Types are documentation — make them explicit.** In a dynamically-typed language
   that offers a type facility, use it: annotate every function signature and every
   class/struct field. Lua uses LuaCATS (`---@class`, `---@field`, `---@param`,
   `---@return`, `---@type`); Python uses type hints. Complex classes especially must
   be fully annotated. This is how rule 3's exception is earned — a field whose type
   states its purpose needs no prose *because* it is typed.
3. **Every function and top-level block is introduced** by exactly one concise line
   (what/why, never how). No function ships unintroduced. Exception: a field whose type
   annotation already states its purpose and expected values.
4. **Comments stay small.** One sentence, no restated logic, no filler. If an
   explanation needs a paragraph, the code needs refactoring instead.
5. **External / non-local state is flagged** at its declaration or use site, so an
   editor hover surfaces it.
6. **Module, class, and library scopes open with a short overview** — a first
   impression of what happens beneath.

## Refactor before you comment

The best comment is often a rename or an extraction. Before writing prose, ask if the
code can say it itself.

- Split large functions into smaller ones with **detailed, intention-revealing names**.
  A good name lets the reader skip the body.
- Move nested or repeated logic into named functions; abstract the scope away.
- Check for code that already exists — reuse and refactor rather than repeat. If two
  places do the same thing, unify them.
- Build with clear intent, simplicity, and isolation. Reach for the known pattern that
  fits the problem; consistent patterns make code predictable to scan.
- Break a rule only when there is genuinely no other way.

## Comments: explicit but small

Reading prose costs the reader's attention — keep every explanation short. If you are
already reading the code, you should not need words to re-explain it.

- **Every function and every top-level block gets a one-line introduction** — what it
  does / why it exists, not how. A function is never left unintroduced.
  - Exception: a field whose type annotation already states its purpose and expected
    values — but only once the annotation actually exists (see Types below).
- **Small helper bodies need no inline comments** — the name and the code suffice.
- **Higher-level scopes get a first-impression summary**: modules, classes, libraries,
  and top-level functions open with a short overview of what happens beneath, so a
  reader knows the shape before reading the parts.
- **Inline / `if` / block comments**: only to make an unobvious purpose clear, in one
  short line. For a genuinely complex algorithm, use terse markers that highlight its
  structure and the meaning the code does not already convey.
- Prefer one plain sentence over several. Cut adjectives, restated logic, and "as you
  can see" filler.

## Types are documentation

In a dynamic language, the type annotation is the field's documentation. Annotate
signatures and every field; do not describe in prose what a type can state. Complex
classes must be fully annotated so a hover explains each part.

Lua (LuaCATS) — a complex class documents itself through its annotations:

```lua
---@class Cache
---@field store table<string, any> Values keyed by their id
---@field ttl integer Seconds an entry stays valid
local Cache = {}

--- Stores a value under an id.
---@param id string
---@param value any
---@return nil
function Cache:set(id, value) end

--- Returns the value for an id, or nil if missing or expired.
---@param id string
---@return any|nil
function Cache:get(id) end
```

Python — hints carry the same weight:

```python
def index_by(items: list[dict], field: str) -> dict:
    """Index items by the given field for O(1) lookup."""
    return {item[field]: item for item in items}
```

## Flag outside state loudly

Poorly-encapsulated code — many states flowing in and out — is the hardest to follow.
The reader (hovering in the editor) must see the danger at the point of use.

- **External sources, side effects, and non-local state get an explicit short note** at
  the declaration or use site: where the value comes from, who else mutates it, what
  assumption it rests on.
- Attach it so an editor hover surfaces it (on the symbol / its docstring).
- This is the one place to be a little more explicit than usual — surprising coupling is
  worth a sentence.

## README / API surface

- Cover only the public API and the minimal configuration to use it.
- Very few words: a usage highlight, the entry points, the essential options. No prose
  tour.

## Anti-patterns to avoid

- Comments that restate the next line.
- Verbose multi-sentence docblocks where one line would do.
- Leaving a function or block with no introduction at all.
- Commenting around bad structure instead of fixing the structure.
- Re-implementing something the codebase already has.
