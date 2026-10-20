// General type styles and objects

// Import chemistry package
// This one changes type slightly
#import "@preview/chemformula:0.1.3": ch
#let chem = ch
// This one has problems
// #import "@preview/chem-par:0.0.1": chem-style
#import "chem.typ": *

// Global variables
#let subject = "Química II"

// #let rohs = image(
//   "assets/engineering/rohs-logo.png",
//   height: 2em,
//   fit: "contain",
//   )
#let rohs(size: 2em) = box(
  baseline: 0.5em,
  image(
    "assets/engineering/rohs-logo.png",
    height: size,
  ),
)

// Basic colours in greys
#let paper = white
#let ink = rgb("#171717")
#let muted = rgb("#6F6F6F")
#let vmuted = rgb("#d6d6d6")
#let accent = rgb("#555555")
#let accent-dark = rgb("#2A2A2A")
#let warm = rgb("#F2F2F2")
#let cool = rgb("#EAEAEA")
#let rule = rgb("#BDBDBD")

// Basic types
#let body-font = ("Libertinus Serif", "New Computer Modern")
#let display-font = ("Libertinus Serif", "New Computer Modern")
#let cover-title-font = ("Libertinus Serif", "GFS Didot", "Didot", "Bodoni Moda")
#let cover-body-font = ("EB Garamond", "Libertinus Serif")

// Links
#show link: it => underline(
  text(fill: accent)[#it]
)

// Basic type sizes
#let body-size = 13pt
#let source-size = 9.5pt
#let small-size = 8pt
#let title-size = 28pt
#let subtitle-size = title-size * 0.47
#let display-size = 20pt
#let section-size = 34pt
#let chapter-size = 130pt
#let headfoot-size = 13pt
#let reference-size = small-size
#let footnote-size = 6pt

#let muted-text(size:body-size, body) = text(size:size, fill: muted, body)
#let muted-colour(body) = text(fill: muted, body)
#let vmuted-colour(body) = text(fill: vmuted, body)
#let shrink-text(factor:0.5, body) = text(size:body-size * factor, body)

// Global book design
#let book-design(body) = {
  set footnote.entry(
    gap: 0.6em,
    clearance: 0em,
    separator: [
     #line(length: 15%, stroke: 0.05em)
     #v(0.5em)
    ],
  )

  show footnote.entry: set text(
    size: footnote-size,
  )

  set text(lang: "es")

  chem-style(body)

}

// Link styles
#let source-link-style(body) = underline(
  text(
    fill: blue,
  )[
    #body
  ]
)

// Paragraph styles
#let chapter-style(body) = {
  set text(
      font: body-font,
      size: chapter-size * 0.4,
      fill: accent-dark,
      weight: 400,
      hyphenate: false,
    )
  set par(leading: 0.5em, justify: false)
  body
}

#let subtitle-style(body) = {
  set text(
      font: body-font,
      size: subtitle-size,
      fill: muted,
      weight: 700,
      hyphenate: false,
    )

  set par(leading: 0.72em, justify: false)
  body
}

#let body-style(body) = {
  set text(
    font: body-font,
    size: body-size,
    fill: ink,
  )

  set par(
    leading: 0.72em,
    justify: true,
    first-line-indent: 1.2em,
  )

  align(left)[
    #body
  ]
}

#let body-style-no-indent(body) = {
  set text(
    font: body-font,
    size: body-size,
    fill: ink,
  )

  set par(
    leading: 0.72em,
    justify: true,
    first-line-indent: 0pt,
  )
  align(left)[
    #body
  ]
}

#let subtle-style(body, size: body-size) = {
  set text(font: body-font, size: size, fill: muted)
  set par(leading: 0.72em, justify: true)
  body
}

#let subtle-it-style(body) = {
  set text(font: body-font, size: body-size, style: "italic", fill: muted)
  set par(leading: 0.72em, justify: true)
  body
}

#let source-body-style(body) = {
  set text(font: body-font, size: source-size, fill: ink)
  set par(leading: 0.70em, justify: true)
  body
}

#let subtitle-style(body) = {
  set text(
      font: body-font,
      size: subtitle-size,
      fill: muted,
      weight: 700,
      hyphenate: false,
    )

  set par(leading: 0.72em, justify: false)
  body
}

#let card-style(body) = {
  set text(
    font: body-font,
    size: body-size,
    fill: ink,
  )

  set par(
    leading: 0.72em,
    justify: true,
    first-line-indent: 0em,
    spacing: 0em,
  )

  align(left)[
    #body
  ]
}

// Text display functions
// ----------------------
#let display(
  body,
  size: display-size,
  weight: 600,
  fill: ink,
) = text(
  font: display-font,
  size: size,
  weight: weight,
  fill: fill,
)[#body]

// Trying to get the text inks of different sizes aligned
#let display-bounds(
  body,
  size: display-size,
  weight: 600,
  fill: ink,
) = text(
  font: display-font,
  size: size,
  weight: weight,
  fill: fill,
  top-edge: "bounds",
  bottom-edge: "bounds",
)[#body]

#let label-txt(
  // Thsi overrides the standard function label
  // So either change the name to label-something
  // Or you can calle stadard label like std.label()
  body,
  fill: muted,
  size: small-size,
  style: "normal",
  weight: 500,
) = text(
  font: display-font,
  size: size,
  style: style,
  weight: weight,
  fill: fill,
)[#body]
