# Condensed Matter Physics — chemistry master edition (Chapter I sample)

This revision **uses the actual original Chemistry II master-page and component
source** (`masters.typ`, `components.typ`, adapted `design.typ`), rather than
imitating its style with standalone page definitions.

## Explicit changes

- `chapter-cover(ch1)` and `section-cover(ch1, sec1_1/sec1_2)` reproduce the
  source chemistry chapter/section master layouts.
- `regular-page(..., chapter: ch1, section: ...)` implements exactly the
  source running header, footer, margins and page-numbering conventions.
- `book-figure(..., chapter: ..., section: ...)` uses the original custom
  **FIGURA I.1.n** caption style and counter logic. Wording in the source
  figure captions is retained, which sometimes includes pre-existing source
  figure labels; that editorial duplication requires review.
- `equation(..., chapter: ..., section: ...)` uses the same warm box,
  **ECUACIÓN I.1.n** style and automatic numbering as the chemistry notes.
- Only chemistry-specific formula imports were removed from `design.typ`;
  the design styling itself is unmodified.

## Compile

From the unzipped folder:

```sh
typst compile book.typ condensed-matter.pdf
```

**Build validation:** Typst executable unavailable in this environment;
source syntax and vertical overflow have NOT been compiler-verified. This
project covers the first 20 PDF source pages only, not all 422.

## Important layout detail

Keep `book.typ`, `masters.typ`, `components.typ`, `design.typ`, `structure.typ`,
`chapters/` and `assets/` in the same project. Open/compile `book.typ` as
entry point. Absolute Typst project paths (`/assets/...`) are intentional.
