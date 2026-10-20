// masters.typ incorporates similar workflow as I had for InDesign

#import "design.typ": *
#import "components.typ": *

// ---------------
// Base for pages
// ---------------
// Global visual language: landscape notes halfway between a slide and a compact textbook.

#let page-width = 297mm
#let page-height = 210mm

#let margin-x = 48pt
#let margin-top = 65pt
#let margin-bottom = 70pt
#let gutter = 26pt

#let _regular-inset = (
  left: 30pt,
  right: 30pt,
  top: 10pt,
  bottom: 30pt,
)

#let _fill(body) = block(
  width: 100%,
  height: 100%,
  breakable: false,
  body,
)

#let _page(
  body,
  numbered: false,
  margin: (
    left: margin-x,
    right: margin-x,
    top: margin-top,
    bottom: margin-bottom,
  ),
  header: none,
  footer: none,
  // Foerground for continuation page
  foreground: none,
) = page(
  width: page-width,
  height: page-height,
  margin: margin,
  fill: paper,
  numbering: if numbered { "1" } else { none },
  header: header,
  footer: footer,
  foreground: foreground,
  body,
)

#let _chapter-label(chapter) = [
  #label-txt(
    chapter.title,
    fill: muted,
    size: headfoot-size,
    style: "italic",
    weight: 500,
  )
]

#let _section-label(chapter, section) = [
  #label-txt(
    chapter.number,
    fill: muted,
    size: headfoot-size,
    style: "italic",
    weight: 500,
  )
  .
  #label-txt(
    section.number,
    fill: muted,
    size: headfoot-size,
    style: "italic",
    weight: 500,
  )
  #h(0.45em)
  #label-txt(
    section.title,
    fill: muted,
    size: headfoot-size,
    style: "italic",
    weight: 500,
  )
]

#let _heading(
  title: none,
  eyebrow: none,
) = block[
  #v(5pt)
  #if eyebrow == none {
    display(
      title,
      size: title-size,
    )
  } else {
    stack(
      dir: ttb,
      spacing: 15pt,
      [
        #label-txt(
          eyebrow,
          fill: muted,
          size: title-size * 0.5,
          weight: 500,
        )
      ],
      [
        #display(
          title,
          size: title-size,
        )
      ],
    )
  }
]


// -------------------------------------
// Chapter cover / section front matter
// -------------------------------------
// If outline it goes in the TOC

#let chapter-cover(
  chapter,
  figure: none,
  outlined: true,
) = _page(
  [
    #if outlined {
      place(top + left)[
        #hide[
          #heading(
            level: 1,
            outlined: true,
            bookmarked: true,
          )[
            #chapter.number #h(0.5em) #chapter.title
          ] #label("tema-" + str(chapter.index))
          // Create the label just after the content
        ]
      ]
    }
    #_fill(
      grid(
        columns: (0.32fr, 0.78fr),
        rows: (1fr,),

        [
          #block(
            width: 100%,
            height: 100%,
            fill: muted,
            inset: (
              left: 42pt,
              right: 40pt,
              top: 120pt,
              bottom: 42pt,
            ),
          )[
            #align(right + top)[
              #display-bounds(
                chapter.number,
                size: chapter-size,
                weight: 650,
                fill: white,
              )
            ]
          ]
        ],
        [
          #grid(
            rows: (auto, 1fr),
            row-gutter: 17pt,
            [
              #block(
                width: 100%,
                inset: (
                  left: 40pt,
                  right: 120pt,
                  top: 130pt,
                  bottom: 20pt,
                ),
              )[
                #display-bounds(
                  size: chapter-size * 0.4,
                  weight: 400,
                  fill: accent-dark,
                )[
                  #chapter-style(chapter.title)
                ]
              ]
            ],
            [
              #block(
                width: 60%,
                height: 100%,
                inset: (
                  left: 40pt,
                  right: 46pt,
                  bottom: 60pt,
                ),
              )[
                #subtle-it-style(chapter.subtitle)

                #if figure != none {
                  v(18pt)
                  align(center)[#figure]
                }

                #if chapter.references != none {
                  v(1fr)
                  line(length: 34pt, stroke: 0.7pt + accent)
                  v(6pt)

                  label-txt(
                    [_Consulta básica_],
                    fill: muted,
                    size: body-size,
                    weight: 650,
                  )

                  v(5pt)
                  subtle-style(chapter.references)
                }
              ]
            ],
          )
        ]
      )
    )
  ],
  margin: 0pt,
)

#let section-cover(
  chapter,
  section,
  subtitle: none,
  figure: none,
) = _page(
  [
    #place(top + left)[
      #hide[
        #heading(
          level: 2,
          outlined: true,
          bookmarked: true,
        )[
          #section.number #h(0.5em) #section.title
        ]
      ]
    ]
    #_fill(
      grid(
        columns: (0.4fr, 0.6fr),
        rows: (1fr,),
        gutter: 20pt,
        [
          #align(right + top)[
            #block(width: 80%)[
              #v(100pt)
              #stack(
                dir: ttb,
                spacing: 30pt,
                [
                  #label-txt(
                    [#chapter.number.#section.number.],
                    fill: accent,
                    size: title-size * 1.4,
                    weight: 650,
                  )
                ],
                [
                  #label-txt(
                    section.title,
                    fill: accent,
                    size: title-size * 1.4,
                    weight: 650,
                  )
                ],
              )
              #if subtitle != none {
                v(12pt)
                text(
                  font: body-font,
                  size: 11.5pt,
                  fill: ink,
                  subtitle,
                )
              }
            ]
          ]
        ],
        [
          #if figure != none {
            block(
              width: 100%,
              height: 100%,
              inset: (
                top: 18pt,
                left: 40pt
              ),
            )[
              #figure
            ]
          }
        ],
      )
    )
  ],
  margin: 54pt,
)


// ==============
// Section pages
// ==============

// -------------
// Regular page
// -------------
// top-right: chapter title
// top-left: Arabic section number + section title
// bottom-right: page number
// No long horizontal rules.
// References use a short rule.

#let _regular-header(
  chapter,
  section,
) = [
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 18pt,
    align: horizon,

    [#align(left)[#_section-label(chapter,section)]],
    [#align(right)[#_chapter-label(chapter)]],
  )
]

// Ruled footer with a possible manual note/reference
#let _regular-footer(
  reference,
) = context [
  #grid(
    columns: (1fr, auto),
    column-gutter: 16pt,
    align: bottom,

    [
      #if reference != none {
        line(length: 32pt, stroke: 0.7pt + accent)
        v(3pt)
        text(
          font: body-font,
          size: footnote-size,
          style: "italic",
          fill: muted,
        )[
          #reference
        ]
      }
    ],

    [
      #label-txt(
        counter(page).display("1"),
        fill: accent-dark,
        size: 12pt,
        weight: 650,
      )
    ],
  )
]

// Simple footer with just page number
// #let _regular-footer(
// ) = context [
//   #grid(
//     columns: (1fr, auto),
//     column-gutter: 16pt,
//     align: bottom,
//     [
//       #label(
//         counter(page).display("1"),
//         fill: accent-dark,
//         size: 12pt,
//         weight: 650,
//       )
//     ],
//   )
// ]

// Natural text flow may span pages
#let regular-page(
  body,
  chapter: none,
  section: none,
  reference: none,
  // Just in case text overflows into a continuation
  foreground: none,
  height: auto,
) = {
  let source-ref = if reference != none {
    reference
  } else {
    none
  }

  _page(
    [
      #block(
        width: 100%,
        height: height,
        inset: _regular-inset,
        // Debugging outline of block for regular page
        // stroke: 2pt + red,
      )[
        #body
      ]
    ],
    numbered: true,
    header: _regular-header(chapter, section),
    footer: _regular-footer(source-ref),
    foreground: foreground,
  )
}

// Slide-like fixed to one page
#let regular-fill(
  body,
  chapter: none,
  section: none,
  reference: none,
  height: auto,
) = {
  let source-ref = if reference != none {
    reference
  } else {
    none
  }

  _page(
    [
      #block(
        width: 100%,
        height: height,
        inset: _regular-inset,
      )[
        #body
      ]
    ],
    numbered: true,
    header: _regular-header(chapter, section),
    footer: _regular-footer(source-ref),
  )
}


// ---------------------------
// TOC: chapters and sections
// ---------------------------
#let toc-page(
  chapter,
  section,
  title: [Contenido],
) = regular-fill(
  grid(
    rows: (auto, 1fr),
    row-gutter: 18pt,

    [#_heading(title: title)],

    [
      #align(left + horizon)[
        #set text(font: body-font, size: 10.5pt, fill: ink)
        #show outline.entry.where(level: 1): set text(
          size: 12.5pt,
          weight: 650,
          fill: accent-dark,
        )
        #show outline.entry.where(level: 1): set block(
          above: 9pt,
          below: 2pt,
        )
        #show outline.entry.where(level: 2): set text(
          size: 9.8pt,
          fill: ink,
        )
        #outline(
          title: none,
          depth: 2,
          indent: 18pt,
        )
      ]
    ],
  ),
  chapter: chapter,
  section: (
    number: section.number,
    title: [Contenido],
    reference: [Estructura general de los apuntes],
  ),
  // reference: [Índice general · capítulos y secciones],
  reference: none,
)


// ----------------------------
// Clear notes avoiding bullets
// ----------------------------
#let course-notes-page(
  chapter,
  section,
  notes,
  title: [Notas],
  orientation: "vertical",
  heading-gap: 28pt,
  main_size: body-size * 1.3,
  detail_size: body-size * 1,
  note-inset: (x: 16pt, y: 14pt),
) = {
  let count = notes.len()
  let tracks = (1fr,) * count

  let note-grid = if orientation == "vertical" {
    grid(
      columns: (1fr,),
      rows: tracks,
      row-gutter: 12pt,

      ..notes.map(note => [
        #course-note(
          note.main,
          detail: note.at("detail", default: none),
          main_size: main_size,
          detail_size: detail_size,
        )
      ])
    )
  } else if orientation == "horizontal" {
    grid(
      columns: tracks,
      rows: (1fr,),
      column-gutter: 20pt,

      ..notes.map(note => [
        #course-note(
          note.main,
          detail: note.at("detail", default: none),
          inset: note-inset,
          main_size: main_size,
          detail_size: detail_size,
        )
      ])
    )
  } else {
    panic("orientation must be \"vertical\" or \"horizontal\"")
  }
  regular-page(
    [
      #grid(
        rows: (auto, 1fr),
        row-gutter: heading-gap,
        [
          #_heading(title: title)
        ],
        [
          #note-grid
        ],
      )
    ],
    chapter: chapter,
    section: (
      number: section.number,
      title: section.title,
    ),
  )
}


// --------------------
// Philosophy of course
// --------------------
#let course-intro-page(
  chapter,
  section,
  body,
  title: none,
  title-gap: 30pt,
) = regular-page(
  [
    #_heading(title: title)

    #v(title-gap)

    #body-style(body)
  ],
  chapter: chapter,
  section: (
    number: section.number,
    title: title,
  ),
)


// ----------------------
// Normal content masters
// ----------------------
#let concept-page(
  body,
  chapter: none,
  section: none,
  title: none,
  page-label: none,
  eyebrow: none,

  figure: none,

  // Tipo de elemento visual:
  //   "image" -> comportamiento histórico con book-figure
  //   "table" -> book-table
  //
  // "image" por defecto para NO romper ninguna página existente.
  figure-type: "image",

  // This does nothing, only left for compatibility
  figure-index: none,

  caption: none,
  caption-title: none,
  short: none,

  figure-stroke: none,
  figure-height: 260pt,

  // Podemos usar el porcentaje de anchura de pagina destinado a la imagen
  ratio: 53%,

  // O calcular el porcentaje a partir de la anchura exacta que yo quiera
  figure-width: 260pt,
  
  table-caption-width: 60%,
  table-caption-gap: 18pt,

  side: "left",
  reference: none,

  // Block to add figure if text overflows to a new page
  continuation-figure: none,
  continuation-content: none,
  continuation-figure-stroke: none,
  continuation-caption-title: none,
  continuation-caption: none,
  continuation-short: none,
  continuation-figure-width: none,
  continuation-figure-height: 60mm,
  continuation-x: 60mm,
  continuation-y: 25mm,

  caption-shift: -48pt,

  continuation-text-width: none,

  // Relacionado con el bug que ubica una footnote en pagina anterior
  // keep-together: false,
) = {

  // ==========================================================
  // VALIDACIÓN
  // ==========================================================

  if figure-type != "image" and figure-type != "table" {
    panic(
      "concept-page: figure-type debe ser \"image\" o \"table\""
    )
  }


  // ==========================================================
  // CAPTION
  // ==========================================================

  let fig-caption = if caption-title != none {
    caption-title
  } else {
    title
  }


  // ==========================================================
  // FIGURE / TABLE CELL
  // ==========================================================
  //
  // Esta es la única modificación importante:
  //
  // image -> comportamiento antiguo EXACTO
  // table -> book-table
  //
  // Para table NO usamos image-frame.
  // ==========================================================

  let figure-cell = if figure == none {
    []
  } else if figure-type == "image" {

    // --------------------------------------------------------
    // IMAGEN
    // --------------------------------------------------------
    // Código histórico: se mantiene igual.
    // --------------------------------------------------------

    align(center + top)[
      #book-figure(
        image-frame(
          figure,
          height: figure-height,
          width: figure-width,
        ),

        chapter: chapter,
        section: section,

        caption-title: fig-caption,
        caption: caption,
        short: short,

        frame-stroke: figure-stroke,
      )
    ]

  } else {

    // --------------------------------------------------------
    // TABLA
    // --------------------------------------------------------
    //
    // figure contiene directamente #table(...)
    //
    // No image-frame.
    // No book-figure.
    // Por tanto no aparecerá una FIGURA adicional.
    // --------------------------------------------------------

    align(center + top)[
      #book-table(
        figure,

        chapter: chapter,
        section: section,

        caption-title: fig-caption,
        caption: caption,
        short: short,

        width: 100%,
        caption-width: table-caption-width,
        caption-gap: table-caption-gap,

        frame-stroke: figure-stroke,
      )
    ]
  }


  // ==========================================================
  // TEXT CELL
  // ==========================================================

  let text-cell = body-style(body)


  // ==========================================================
  // ORDER
  // ==========================================================

  let first-cell = if side == "left" {
    figure-cell
  } else {
    text-cell
  }

  let second-cell = if side == "left" {
    text-cell
  } else {
    figure-cell
  }


  // ==========================================================
  // COLUMNS
  // ==========================================================

  let columns = if side == "left" {

    // con el porcentaje ratio
    // (ratio, 1fr)

    // con la anchura de figura exacta
    (figure-width, 1fr)

  } else {

    // (1fr, ratio)

    (1fr, figure-width)
  }


// ==========================================================
// CONTINUATION PAGE DEFINITIONS
// ==========================================================
//
// Retrocompatible:
//
// - continuation-content != none
//     -> usa contenido Typst: texto, ecuaciones, tablas, etc.
//
// - continuation-content == none
//   y continuation-figure != none
//     -> comportamiento histórico con image-frame.
//
// Si se proporcionan ambos, continuation-content tiene prioridad.
// ==========================================================


// Anchura exterior de la figura de continuación.
let cont-width = if continuation-figure-width == none {
  figure-width
} else {
  continuation-figure-width
}


// Anchura del contenido textual dentro de la figura.
// Solo afecta a continuation-content.
let cont-text-width = if continuation-text-width == none {
  100%
} else {
  continuation-text-width
}


// ----------------------------------------------------------
// CONTENIDO DE LA FIGURA DE CONTINUACIÓN
// ----------------------------------------------------------

let continuation-visual = if continuation-content != none {

  // --------------------------------------------------------
  // CONTENIDO TYPST
  // --------------------------------------------------------
  //
  // Puede contener texto, ecuaciones, listas, tablas,
  // diagramas, etc.
  // --------------------------------------------------------

  block(
    width: cont-text-width,
    inset: 8pt,
  )[
    #continuation-content
  ]

} else if continuation-figure != none {

  // --------------------------------------------------------
  // IMAGEN
  // --------------------------------------------------------
  //
  // Comportamiento histórico.
  // Se mantiene para no alterar páginas existentes.
  // --------------------------------------------------------

  image-frame(
    continuation-figure,
    width: 100%,
    height: continuation-figure-height,
  )

} else {

  none
}


// ----------------------------------------------------------
// COLOCACIÓN EN LA PÁGINA DE CONTINUACIÓN
// ----------------------------------------------------------

let continuation-foreground = if continuation-visual == none or short == none {
    none
  } else {
    context {
      let first-page = locate(label(short)).page()

      if here().page() == first-page + 1 {

        let pos = if side == "left" {
          top + left
        } else {
          top + right
        }

        let dx = if side == "left" {
          continuation-x
        } else {
          -continuation-x
        }

        place(
          pos,

          dx: dx,
          dy: continuation-y,

          box(
            width: cont-width,
          )[
            #book-figure(
              continuation-visual,

              chapter: chapter,
              section: section,

              caption-title: continuation-caption-title,
              caption: continuation-caption,
              short: continuation-short,

              frame-stroke: continuation-figure-stroke,
              width: 100%,

              // There was an abnormally large gap between
              // figure and caption in continuation figures,
              // so this remains manually adjustable.
              caption-shift: caption-shift,
            )
          ],
        )
      }
    }
  }


  // ==========================================================
  // CELL ALIGNMENT
  // ==========================================================

  let cell-align = if side == "left" {
    (
      center + top,
      left + top,
    )
  } else {
    (
      left + top,
      center + top,
    )
  }


  // ==========================================================
  // PAGE
  // ==========================================================

  regular-page(
    [
      #if page-label != none {
        page-label
      }

      #block(sticky: true)[
        #_heading(
          title: title,
          eyebrow: eyebrow,
        )
      ]

      #v(15pt)

      #grid(
        columns: columns,
        rows: (auto,),
        column-gutter: gutter,

        first-cell,
        second-cell,
      )
    ],

    chapter: chapter,
    section: section,
    reference: reference,
    foreground: continuation-foreground,
  )
}

#let text-page(
  body,
  chapter: none,
  section: none,
  title: none,
  eyebrow: none,
  reference: none,
) = regular-fill(
  grid(
    rows: (auto, 1fr),
    row-gutter: 15pt,
    [#_heading(title: title, eyebrow: eyebrow)],
    [#align(left + horizon)[#body-style(body)]],
  ),
  chapter: chapter,
  section: section,
  reference: reference,
)

#let split-page(
  chapter: none,
  section: none,
  title: none,
  eyebrow: none,
  left-body: none,
  right-body: none,
  ratio: (1fr, 1fr),
  reference: none,
) = regular-page(
  _fill(
    grid(
      rows: (auto, 1fr),
      row-gutter: 15pt,
      [#_heading(title: title, eyebrow: eyebrow)],
      [
        #grid(
          columns: ratio,
          rows: (1fr,),
          column-gutter: gutter,
          align: (left + horizon, left + horizon),
          [#body-style(left-body)],
          [#body-style(right-body)],
        )
      ],
    )
  ),
  chapter: chapter,
  section: section,
  reference: reference,
)

#let summary-page(
  body,
  chapter: none,
  section: none,
  title: none,
  reference: none,
  eyebrow: [Síntesis]
) = regular-page(
  _fill(
    grid(
      rows: (auto, 1fr),
      row-gutter: 17pt,
      [#_heading(title: title, eyebrow: eyebrow)],
      [#align(left + horizon)[#body-style(body)]],
    )
  ),
  chapter: chapter,
  section: section,
  reference: reference,
)

#let full-figure-page(
  chapter,
  section,
  body,

  caption-title: none,
  caption: none,
  short: none,

  figure-width: 70%,
  caption-side: "right",
  caption-gap: 14pt,

  height: 100%,

  frame-stroke: none,

  reference: none,
) = {
  regular-fill(
    [
      #align(center + horizon)[
        #book-side-figure(
          body,

          chapter: chapter,
          section: section,

          caption-title: caption-title,
          caption: caption,

          short: short,

          figure-width: figure-width,
          caption-side: caption-side,
          caption-gap: caption-gap,

          frame-stroke: frame-stroke,

        )
      ]
    ],

    chapter: chapter,
    section: section,
    reference: reference,
    height: height,
  )
}

// ------------------------------------------------------------
// Source-material page used for the newly imported decks.
// ------------------------------------------------------------

#let source-page(
  body,
  chapter: none,
  section: none,
  title: none,
  visual: none,
  figure-index: 1,
  figure-caption: none,
  reference: none,
) = {
  let content = if visual == none {
    _fill(
      grid(
        rows: (auto, 1fr),
        row-gutter: 14pt,
        [#_heading(title: title)],
        [#align(left + horizon)[#source-body-style(body)]],
      )
    )
  } else {
    _fill(
      grid(
        rows: (auto, 1fr),
        row-gutter: 14pt,

        [#_heading(title: title)],

        [
          #grid(
            columns: (1.04fr, 0.96fr),
            rows: (1fr,),
            column-gutter: 24pt,
            align: (left + horizon, center + horizon),

            [#source-body-style(body)],

            [
              #book-figure(
                visual,
                chapter: chapter,
                section: section,
                index: figure-index,
                caption: if figure-caption == none {
                  title
                } else {
                  figure-caption
                },
              )
            ],
          )
        ],
      )
    )
  }

  regular-page(
    content,
    chapter: chapter,
    section: section,
    reference: reference,
  )
}
