# Condensed Matter Physics — native Typst conversion, chapter I opening

**What this delivers:** actual editable Typst text and mathematical equations for source PDF pages 1–20, with progressive stages consolidated, and retained cropped source diagrams. Chapter and section opening page layouts, grayscale colours and serif typography are adapted directly from the Chemistry II project. The ORIGINAL chemistry files are included unchanged in `chemistry_style_original/`.

**What this does not yet deliver:** the remaining source pages 21–422, complete redrawing of diagrams, or a PDF compiled and visually checked. The environment did not have a Typst executable, and installation was blocked; consequently this is an uncompiled source deliverable, not a certified build.

## Build

From this folder, with Typst installed:

```sh
typst compile book.typ condensed-matter.pdf
```

## Source coverage audit

- Original PDF pp. 1–2: chapter / section openings.
- pp. 3–6: consolidated discussion of long- and short-range order.
- pp. 7–8: crystal lattice + motif.
- pp. 9–10: lattice translations, equations (I.1) and (I.2).
- p. 11: photographic illustration.
- pp. 12–13: definitions and equations (I.3)–(I.5).
- p. 14: section 2 cover.
- p. 15: primitive vectors and lattice, Figure I.2.
- pp. 16–18: centered lattice, Figure I.3 final annotated state.
- pp. 19–20: unit cells, Figure I.4 and its successive state.

This is a substantive **partial conversion**, not the full book. Some source diagrams are crops, not yet vectors. Prior extraction mistakes must be reviewed against the original PDF during the next quality pass; exact 1:1 layout, line breaks, and pagination are deliberately not claimed.
