// Adapted from the supplied chemistry Typst design: same monochrome visual vocabulary,
// serif typography, landscape A4, spacious margins, subdued figure captions.
#let paper = white
#let ink = rgb("#171717")
#let muted = rgb("#6F6F6F")
#let accent = rgb("#555555")
#let warm = rgb("#F2F2F2")
#let cool = rgb("#EAEAEA")
#let rule = rgb("#BDBDBD")
#let body-font = ("Libertinus Serif", "New Computer Modern")
#let display-font = ("Libertinus Serif", "New Computer Modern")
#let body-size = 13pt

#let setup(body) = {
  set page(width: 297mm, height: 210mm, margin: (left: 23mm, right: 23mm, top: 21mm, bottom: 20mm), fill: paper)
  set text(font: body-font, size: body-size, fill: ink, lang: "en")
  set par(leading: 0.72em, justify: true)
  set heading(numbering: none)
  body
}
#let small-label(t) = text(size: 9pt, fill: muted, weight: "medium")[#t]
#let title(t) = text(font: display-font, size: 32pt, weight: "regular")[#t]
#let page-title(t) = text(font: display-font, size: 27pt, weight: "regular")[#t]
#let body-note(t) = block(fill: cool, inset: 12pt, radius: 2pt, width: 100%)[#t]
#let formula(eq, tag: none) = block(width: 100%, fill: warm, inset: 13pt, radius: 2pt)[
  #grid(columns: (1fr, auto, 1fr), align: (left, center, right), [], [#eq], [#if tag != none {small-label(tag)}])
]
#let source-page(page-no) = text(size: 9pt, fill: muted)[Original lecture notes · PDF p. #page-no]
#let figure-image(path, caption: none, width: 100%) = {
  image(path, width: width, fit: "contain")
  if caption != none { v(5pt); text(size: 9pt, fill: muted)[#caption] }
}
#let chapter-opening(n, t, refs) = {
  small-label[CONDENSED MATTER PHYSICS · CHAPTER #n]
  v(35mm)
  text(size: 68pt, weight: "regular", fill: accent)[#n]
  v(5mm)
  title(t)
  v(14mm)
  line(length: 45mm, stroke: 0.5pt + rule)
  v(8mm)
  text(size: 10pt, fill: muted)[#refs]
  pagebreak()
}
#let section-opening(n, t) = {
  small-label[CHAPTER I · #n]
  v(45mm)
  page-title(t)
  v(8mm)
  line(length: 45mm, stroke: 0.5pt + rule)
  pagebreak()
}
#let lecture-page(heading, page-no, body) = {
  small-label[CHAPTER I · CRYSTAL STRUCTURE]
  v(7mm)
  page-title(heading)
  v(9mm)
  body
  v(1fr)
  line(length: 100%, stroke: 0.4pt + rule)
  v(3pt)
  source-page(page-no)
  pagebreak()
}
