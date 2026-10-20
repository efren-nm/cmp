// components.typ
#import "design.typ": *

#let lead(body) = block(
  below: 10pt,
  text(font: body-font, size: 12.5pt, fill: ink, body),
)

#let definition(
  body,
  title: none,
) = block(
  width: 100%,
  inset: 11pt,
  fill: cool,
  radius: 2pt,
  [
    #if title != none {
      display(title, size: 11.5pt, weight: 650)
      v(5pt)
    }
    #body-style(body)
  ],
)

#let note(
  body,
  title: none,
) = block(
  width: 100%,
  inset: (left: 11pt, right: 11pt, top: 8pt, bottom: 8pt),
  stroke: (left: 1.2pt + accent),
  [
    #if title != none {
      display(title, size: 10pt, weight: 650, fill: accent-dark)
      v(4pt)
    }
    #body-style-no-indent(body)
  ],
)

#let equation(
  body,
  tag: none,
  width: 100%,
  chapter: none,
  section: none,
  eq-label: none,
) = {
  let numbered = chapter != none and section != none

  if numbered {
    let eq-kind = "book-equation-" + str(chapter.index) + "-" + str(section.number)

    let eq-numbering = n => numbering(
      "I.1.1",
      chapter.index,
      section.number,
      n,
    )

    show figure.where(kind: eq-kind): it => {
      block(
        width: width,
        inset: (x: 12pt, y: 9pt),
        fill: warm,
        radius: 2pt,
      )[
        #if tag != none {
          label-txt(tag, fill: accent-dark)
          v(5pt)
        }

        #grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right + horizon),

          [],

          [
            #text(
              font: body-font,
              size: body-size,
              fill: ink,
            )[
              #it.body
            ]
          ],

          [
            #text(
              font: display-font,
              size: body-size * 0.7,
              weight: 600,
              fill: accent-dark,
            )[
              ECUACIÓN
              #context it.counter.display(it.numbering)
            ]
          ],
        )
      ]
    }

    [
      #figure(
        body,
        kind: eq-kind,
        supplement: [Ecuación],
        numbering: eq-numbering,
        outlined: false,
      )
      #if eq-label != none {
        eq-label
      }
    ]
  } else {
    block(
      width: width,
      inset: (x: 12pt, y: 9pt),
      fill: warm,
      radius: 2pt,
    )[
      #if tag != none {
        label-txt(tag, fill: accent-dark)
        v(5pt)
      }

      #text(
        font: body-font,
        size: 14pt,
        fill: ink,
      )[
        #body
      ]
    ]
  }
}

#let equation-no-label(
  body,
  tag: none,
  width: 100%,
  chapter: none,
  section: none,
) = {
  block(
    width: width,
    inset: (x: 12pt, y: 9pt),
    fill: none,
    radius: 2pt,
  )[
    #if tag != none {
      label-txt(tag, fill: accent-dark)
      v(5pt)
    }

    #grid(
      columns: (1fr, auto, 1fr),
      align: (left, center, right + horizon),

      [],

      [
        #text(
          font: body-font,
          size: body-size,
          fill: ink,
        )[
          #body
        ]
      ],

      [],
    )
  ]
}

#let table-span(
  body,

  chapter: none,
  section: none,

  caption-title: none,
  caption: none,
  caption-width: 30%,

  short: none,

  // Espacio disponible para la tabla.
  left-pad: 0pt,
  right-pad: 0pt,

  // Distancia tabla → caption.
  caption-gap: 7pt,

  frame-stroke: none,
) = {
  // Contador independiente de las figuras,
  // pero con la misma lógica capítulo.sección.número.
  let table-kind = "book-table-" + str(chapter.index) + "-" + str(section.number)

  let table-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let make-table = () => figure(
    block(
      width: 100%,
      spacing: 0pt,
      stroke: frame-stroke,
    )[
      #body
    ],

    kind: table-kind,
    supplement: [Tabla],
    numbering: table-numbering,
    outlined: false,

    // Caption lógico para que figure mantenga
    // numeración y referencias.
    caption: if caption-title != none or caption != none {
      []
    } else {
      none
    },
  )

  let table-layout(it) = block(
    width: 100%,
    inset: (
      left: left-pad,
      right: right-pad,
    ),
  )[
    // La tabla queda centrada dentro del espacio
    // delimitado por left-pad/right-pad.
    #align(center)[
      #it.body
    ]

#if caption-title != none or caption != none {
  v(caption-gap)

  align(right)[
    #block(
      width: caption-width,
    )[
      #align(right)[
        #par(
          hanging-indent: 1.8em,
        )[
          #text(
            font: display-font,
            size: 7.7pt,
            weight: 650,
            tracking: 0.06em,
            fill: accent-dark,
          )[
            TABLA #context it.counter.display(it.numbering).
          ]

          #h(0.1em)

          #if caption-title != none {
            text(
              font: body-font,
              size: 8.5pt,
              weight: 700,
              fill: accent-dark,
            )[
              #caption-title
            ]
          }

          #if caption != none {
            h(0.1em)

            text(
              font: body-font,
              size: 8.5pt,
              weight: 400,
              style: "normal",
              fill: muted,
            )[
              #caption
            ]
          }
        ]
      ]
    ]
  ]
}
  ]

  if short == none {
    [
      #show figure.where(kind: table-kind): table-layout
      #make-table()
    ]
  } else {
    [
      #show figure.where(kind: table-kind): table-layout
      #make-table()
      #label(short)
    ]
  }
}

#let book-table(
  body,

  chapter: none,
  section: none,

  caption-title: none,
  caption: none,

  short: none,

  // Tamaño dentro del espacio que le dé el master.
  width: 100%,

  // Padding respecto al espacio disponible.
  left-pad: 0pt,
  right-pad: 0pt,

  // Caption bajo la tabla, alineado a la derecha.
  caption-width: 35%,
  caption-gap: 5pt,

  frame-stroke: none,
) = {
  // MISMO kind que table-span:
  // ambas comparten contador.
  let table-kind = "book-table-" + str(chapter.index) + "-" + str(section.number)

  let table-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let make-table = () => figure(
    block(
      width: width,
      spacing: 0pt,
      stroke: frame-stroke,
      inset: (
        left: left-pad,
        right: right-pad,
      ),
    )[
      #align(center)[
        #body
      ]
    ],

    kind: table-kind,
    supplement: [Tabla],
    numbering: table-numbering,
    outlined: false,

    gap: caption-gap,

    caption: if caption-title != none or caption != none {
      []
    } else {
      none
    },
  )

  let caption-style(it) = block(
    width: width,
    above: 0pt,
    below: 0pt,
    inset: (
      left: left-pad,
      right: right-pad,
    ),
  )[
    #align(right)[
      #block(
        width: caption-width,
      )[
        #align(right)[
          #par(
            hanging-indent: 1.8em,
          )[
            #text(
              font: display-font,
              size: 7.7pt,
              weight: 650,
              tracking: 0.06em,
              fill: accent-dark,
            )[
              TABLA #context it.counter.display(it.numbering).
            ]

            #h(0.1em)

            #if caption-title != none {
              text(
                font: body-font,
                size: 8.5pt,
                weight: 700,
                fill: accent-dark,
              )[
                #caption-title
              ]
            }

            #if caption != none {
              h(0.1em)

              text(
                font: body-font,
                size: 8.5pt,
                weight: 400,
                style: "normal",
                fill: muted,
              )[
                #caption
              ]
            }
          ]
        ]
      ]
    ]
  ]

  if short == none {
    [
      #show figure.caption: caption-style
      #make-table()
    ]
  } else {
    [
      #show figure.caption: caption-style
      #make-table()
      #label(short)
    ]
  }
}

#let quote-box(
  body,
  attribution: none,
) = block(
  width: 100%,
  inset: 13pt,
  fill: cool,
  radius: 2pt,
  [
    #text(font: body-font, size: 12.5pt, style: "italic")[#body]
    #if attribution != none {
      v(6pt)
      align(right)[#label-txt(attribution)]
    }
  ],
)

// Image components
// Right now:
/* concept-page
→ fig(...)
     → image(...)
→ image-frame(...)
  → block(...)
→ book-figure(...) */

#let fig(
  path,
  alt: "",
  height: 100%,
  fit-frame: "cover",
) = image(
  path,
  width: 100%,
  height: height,
  fit: fit-frame,
  alt: alt,
)

#let image-frame(
  figure,
  height: 260pt,
  width: 100%,
  align-x: center,
  align-y: horizon,
) = block(
  width: width,
  height: height,
  clip: true,
)[
  #align(align-x + align-y)[
    #figure
  ]
]

#let source-paragraph(text-body) = block(
  below: 5.5pt,
  text(
    font: body-font,
    size: source-size,
    fill: ink,
    text-body,
  ),
)


// Compact engineering connection embedded in descriptive chemistry pages.
#let engineering-corollary(
  body,
  source: none,
) = block(
  width: 100%,
  above: 5pt,
  inset: (
    left: 8pt,
    right: 6pt,
    top: 5pt,
    bottom: 5pt,
  ),
  fill: cool,
  stroke: (left: 1pt + accent),
  radius: 1.5pt,
  [
    #label-txt(
      [COROLARIO · INGENIERÍA],
      fill: accent-dark,
      size: 6.7pt,
      weight: 700,
    )
    #v(2.5pt)

    #text(
      font: body-font,
      size: 7.35pt,
      fill: ink,
    )[
      #set par(leading: 0.58em, justify: true, first-line-indent: 0em,)
      #body
    ]

    #if source != none {
      v(2.5pt)
      label-txt(
        source,
        fill: muted,
        size: 6.1pt,
        weight: 500,
      )
    }
  ],
)

#let engineering-idea(
  body,
  source: none,
) = block(
  width: 100%,
  above: 5pt,
  inset: (
    left: 10pt,
    right: 12pt,
    top: 10pt,
    bottom: 12pt,
  ),
  fill: cool,
  stroke: (left: 1pt + accent),
  radius: 1.5pt,
  [
    #label-txt(
      [APLICACIÓN · INGENIERÍA],
      fill: accent-dark,
      size: 8pt,
      weight: 700,
    )
    #v(2.5pt)

    #text(
      font: body-font,
      size: body-size*0.7,
      fill: ink,
    )[
      #set par(leading: 0.65em, justify: true, first-line-indent: 0em,)
      #body
    ]

    #if source != none {
      v(2.5pt)
      set par(leading: 0.65em, justify: true, first-line-indent: 0em,)
      label-txt(
        source,
        fill: muted,
        size: 6.1pt,
        weight: 500,
      )
    }
  ],
)

#let source-link(url, body) = link(
  url,
  text(fill: accent-dark, body),
)

// Figure with elegant book-style caption.
#let _book-figure-caption(
  it,
  caption-title: none,
  caption: none,
  caption-shift: 0pt,
  side-align: left,
  caption-inset: (
    left: 5%,
    right: 5%,
  ),
  hanging-indent: 1.8em,
) = move(
  dy: caption-shift,

  block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    inset: caption-inset,
  )[
    // Hace que el borde inferior tipográfico de la última
    // línea coincida con su baseline.
    #set text(bottom-edge: "baseline")

    #align(side-align)[
      #par(
        hanging-indent: hanging-indent,
      )[
        #text(
          font: display-font,
          size: 7.7pt,
          weight: 650,
          tracking: 0.06em,
          fill: accent-dark,
        )[
          FIGURA #context it.counter.display(it.numbering).
        ]

        #h(0.1em)

        #if caption-title != none {
          text(
            font: body-font,
            size: 8.5pt,
            weight: 700,
            fill: accent-dark,
          )[
            #caption-title
          ]
        }

        #if caption != none {
          h(0.1em)

          text(
            font: body-font,
            size: 8.5pt,
            weight: 400,
            style: "normal",
            fill: muted,
          )[
            #caption
          ]
        }
      ]
    ]
  ]
)

#let book-figure(
  body,
  chapter: none,
  section: none,
  index: none, // kept temporarily for compatibility
  caption-title: none,
  caption: none,
  caption-shift: 0pt,
  short: none,
  width: 100%,
  gap: 25pt,
  frame-stroke: none,
) = {
  // Each chapter/section gets its own automatic figure counter.
  let fig-kind = "book-figure-" + str(chapter.index) + "-" + str(section.number)

  // Typst supplies n automatically from the figure counter.
  let fig-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let make-figure = () => figure(
    block(
      width: width,
      spacing: 0pt,
      stroke: frame-stroke,
      [
        #align(center)[#body]
      ],
    ),

    kind: fig-kind,
    supplement: [Figura],
    numbering: fig-numbering,
    outlined: false,

    // Increase this to recover the old visual spacing.
    gap: gap,

    // The actual visual caption is created by caption-style below.
    caption: if caption-title != none or caption != none {
      []
    } else {
      none
    },
  )

  let caption-style(it) = _book-figure-caption(
    it,
    caption-title: caption-title,
    caption: caption,
    caption-shift: caption-shift,
  )

  if short == none {
    [
      #show figure.caption: caption-style
      #make-figure()
    ]
  } else {
    [
      #show figure.caption: caption-style
      #make-figure()
      #label(short)
    ]
  }
}

#let book-side-figure(
  body,

  chapter: none,
  section: none,

  index: none, // compatibilidad; no se usa

  caption-title: none,
  caption: none,

  short: none,

  // Anchura de la figura dentro del área útil.
  figure-width: 70%,

  // "left" o "right".
  caption-side: "right",

  // Separación entre caption e imagen.
  caption-gap: 14pt,

  frame-stroke: none,
) = {
  if caption-side != "left" and caption-side != "right" {
    panic(
      "book-side-figure: caption-side debe ser \"left\" o \"right\""
    )
  }

  // EXACTAMENTE el mismo contador que book-figure.
  let fig-kind = "book-figure-" + str(chapter.index) + "-" + str(section.number)

  let fig-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let make-figure = () => figure(
    block(
      width: 100%,
      spacing: 0pt,
      stroke: frame-stroke,
    )[
      #align(center)[#body]
    ],

    kind: fig-kind,
    supplement: [Figura],
    numbering: fig-numbering,
    outlined: false,

    // Necesitamos que la figura sea numerada,
    // pero el caption visual lo dibujamos lateralmente.
    caption: if caption-title != none or caption != none {
      []
    } else {
      none
    },
  )

  let side-caption(it, side) = {
    let caption-align = if side == "left" {
      left
    } else {
      right
    }

    let inner-inset = if side == "left" {
      (
        left: 0pt,
        right: caption-gap,
      )
    } else {
      (
        left: caption-gap,
        right: 0pt,
      )
    }

    block(
      width: 100%,
      inset: inner-inset,
      above: 0pt,
      below: 0pt,
    )[
      #_book-figure-caption(
        it,
        caption-title: caption-title,
        caption: caption,

        // Izquierda → texto a izquierda.
        // Derecha → texto a derecha.
        side-align: caption-align,

        // Aquí no queremos el 5 % de margen
        // usado por los captions inferiores normales.
        caption-inset: 0pt,

        // Para caption lateral no usamos hanging indent.
        hanging-indent: 0pt,
      )
    ]
  }

  let side-style(it) = grid(

    // La columna central está SIEMPRE centrada.
    columns: (
      1fr,
      figure-width,
      1fr,
    ),

    // Sin gutter: así el centro geométrico no cambia.
    column-gutter: 0pt,

    // Las tres cajas reposan sobre la misma línea inferior.
    align: (
      left + bottom,
      center + bottom,
      right + bottom,
    ),

    // IZQUIERDA
    [
      #if caption-side == "left" {
        side-caption(it, "left")
      }
    ],

    // CENTRO
    [
      #it.body
    ],

    // DERECHA
    [
      #if caption-side == "right" {
        side-caption(it, "right")
      }
    ],
  )

  if short == none {
    [
      #show figure.where(kind: fig-kind): side-style
      #make-figure()
    ]
  } else {
    [
      #show figure.where(kind: fig-kind): side-style
      #make-figure()
      #label(short)
    ]
  }
}

#let inline-side-figure(
  body,

  chapter: none,
  section: none,

  caption-title: none,
  caption: none,
  short: none,

  caption-side: "right",

  // Anchura de la columna del caption.
  // La figura NO depende de esto.
  caption-width: 32mm,

  // Única separación entre figura y caption.
  caption-gap: 12pt,

  frame-stroke: none,
) = {
  if caption-side != "left" and caption-side != "right" {
    panic(
      "inline-side-figure: caption-side debe ser \"left\" o \"right\""
    )
  }

  // Mismo kind que book-figure:
  // comparte la numeración general de figuras.
  let fig-kind = "book-figure-" + str(chapter.index) + "-" + str(section.number)

  let fig-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let make-figure = () => figure(
    block(
      spacing: 0pt,
      stroke: frame-stroke,
    )[
      #body
    ],

    kind: fig-kind,
    supplement: [Figura],
    numbering: fig-numbering,
    outlined: false,

    // Figure necesita caption para disponer del contador,
    // pero visualmente lo sustituimos lateralmente.
    caption: [],
  )

  let make-caption(it) = {
    let side-align = if caption-side == "right" {
      right
    } else {
      left
    }

    let side-inset = if caption-side == "right" {
      (
        left: caption-gap,
      )
    } else {
      (
        right: caption-gap,
      )
    }

    block(
      width: caption-width,
      inset: side-inset,
      above: 0pt,
      below: 0pt,
    )[
      #set par(
        justify: false,
        leading: 3pt,
      )
      // #set text(bottom-edge: "baseline")

      #align(side-align)[
        #text(
          font: display-font,
          size: 7.7pt,
          weight: 650,
          tracking: 0.06em,
          fill: accent-dark,
        )[
          FIGURA #context it.counter.display(it.numbering).
        ]

        #if caption-title != none {
          h(0.1em)

          text(
            font: body-font,
            size: 8.5pt,
            weight: 700,
            fill: accent-dark,
          )[
            #caption-title
          ]
        }

        #if caption != none {
          h(0.1em)

          text(
            font: body-font,
            size: 8.5pt,
            weight: 400,
            fill: muted,
          )[
            #caption
          ]
        }
      ]
    ]
  }

  let layout(it) = align(center)[
    #if caption-side == "left" {
      grid(
        columns: (auto, auto),
        column-gutter: 0pt,
        align: (right + bottom, left + bottom),

        [
          #make-caption(it)
        ],

        [
          #it.body
        ],
      )
    } else {
      grid(
        columns: (auto, auto),
        column-gutter: 0pt,
        align: (right + bottom, left + bottom),

        [
          #it.body
        ],

        [
          #make-caption(it)
        ],
      )
    }
  ]

  if short == none {
    [
      #show figure.where(kind: fig-kind): layout
      #make-figure()
    ]
  } else {
    [
      #show figure.where(kind: fig-kind): layout
      #make-figure()
      #label(short)
    ]
  }
}

#let figure-span(
  body,
  chapter: none,
  section: none,
  caption-title: none,
  caption: none,
  short: none,
  width: 100%,
  gap: 18pt,
  frame-stroke: none,
) = block(
  width: 100%,
  breakable: false,
)[
  #align(center)[
    #book-figure(
      body,
      chapter: chapter,
      section: section,
      caption-title: caption-title,
      caption: caption,
      short: short,
      width: width,
      gap: gap,
      frame-stroke: frame-stroke,
    )
  ]
]

#let see-figure(
  target,
  prefix: [ver],
) = [
  #prefix #ref(
    target,
    supplement: [Figura],
  ) en la #ref(
    target,
    form: "page",
    supplement: [pág.],
  )
]

#let see-table(
  target,
  prefix: [ver],
) = [
  #prefix #ref(
    target,
    supplement: [Tabla],
  ) en la #ref(
    target,
    form: "page",
    supplement: [pág.],
  )
]

#let inline-side-image(
  source,

  chapter: none,
  section: none,

  caption-title: none,
  caption: none,
  short: none,

  // Sólo fijamos la altura.
  // El ancho se calcula automáticamente según la proporción de la imagen.
  image-height: 30%,

  caption-side: "right",
  caption-width: 30mm,
  caption-gap: 8pt,

  frame-stroke: none,
) = {
  if caption-side != "left" and caption-side != "right" {
    panic(
      "inline-side-image: caption-side debe ser \"left\" o \"right\""
    )
  }

  // Exactamente el mismo kind que book-figure.
  let fig-kind = "book-figure-" + str(chapter.index) + "-" + str(section.number)

  let fig-numbering = n => numbering(
    "I.1.1",
    chapter.index,
    section.number,
    n,
  )

  let image-body = box[
    #image(
      source,
      height: image-height,
      fit: "contain",
    )
  ]

  let make-figure = () => figure(
    image-body,

    kind: fig-kind,
    supplement: [Figura],
    numbering: fig-numbering,
    outlined: false,

    // Caption lógico para que exista el figure.caption;
    // el aspecto visual lo sustituimos.
    caption: [],
  )

  let make-caption(it) = {
    let caption-align = if caption-side == "right" {
      right
    } else {
      left
    }

    let caption-inset = if caption-side == "right" {
      (left: caption-gap)
    } else {
      (right: caption-gap)
    }

    block(
      width: caption-width,
      inset: caption-inset,
      above: 0pt,
      below: 0pt,
    )[
      #align(caption-align)[
        #par(
          hanging-indent: 1.8em,
          justify: false,
        )[
          #text(
            font: display-font,
            size: 7.7pt,
            weight: 650,
            tracking: 0.06em,
            fill: accent-dark,
          )[
            FIGURA #context it.counter.display(it.numbering).
          ]

          #h(0.1em)

          #if caption-title != none {
            text(
              font: body-font,
              size: 8.5pt,
              weight: 700,
              fill: accent-dark,
            )[
              #caption-title
            ]
          }

          #if caption != none {
            h(0.1em)

            text(
              font: body-font,
              size: 8.5pt,
              weight: 400,
              style: "normal",
              fill: muted,
            )[
              #caption
            ]
          }
        ]
      ]
    ]
  }

  let layout(it) = align(center)[
    #if caption-side == "left" {
      grid(
        columns: (auto, auto),
        column-gutter: 0pt,
        align: (right + bottom, left + bottom),

        [#make-caption(it)],
        [#it.body],
      )
    } else {
      grid(
        columns: (auto, auto),
        column-gutter: 0pt,
        align: (right + bottom, left + bottom),

        [#it.body],
        [#make-caption(it)],
      )
    }
  ]

  if short == none {
    [
      #show figure.where(kind: fig-kind): layout
      #make-figure()
    ]
  } else {
    [
      #show figure.where(kind: fig-kind): layout
      #make-figure()
      #label(short)
    ]
  }
}

// ------------------------------------------
// Legacy components still used by Chapter I.
// Kept here so the older curated material and the newer chapters use
// the same design system.
// ------------------------------------------
#let mini-card(
  body,
  title: none,
  subtitle: none,
  card-tit: 20pt,
) = block(
  width: 100%,
  inset: 10pt,
  stroke: 0.55pt + rule,
  radius: 4pt,
  [
    #if title != none {
      set par(
        first-line-indent: 0pt,
        hanging-indent: 0pt,
        // leading: 0em,
        spacing: 0.5em,
      )
      display(title, size: card-tit, weight: 650)
    }
    #if subtitle != none {
      set par(
        first-line-indent: 0pt,
        hanging-indent: 0pt,
        // leading: 0em,
        spacing: 0em,
      )
      v(0pt)
      display(subtitle, size: body-size, weight: 350, fill:muted)
    }
    #v(30pt)

    #card-style(body)
  ],
)

#let three-cards(
  a-title: none,
  a-subtitle: none,
  a: none,
  b-title: none,
  b-subtitle: none,
  b: none,
  c-title: none,
  c-subtitle: none,
  c: none,
) = grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 10pt,

  mini-card(a, title: a-title, subtitle: a-subtitle,),
  mini-card(b, title: b-title, subtitle: b-subtitle,),
  mini-card(c, title: c-title, subtitle: c-subtitle,),
)

#let orbital-row(
  cells,
  label-text: none,
) = grid(
  columns: (52pt, 1fr),
  column-gutter: 8pt,
  align: horizon,

  [#label-txt(label-text, fill: accent-dark, size: 8pt, weight: 600)],
  [#text(font: body-font, size: 15pt, fill: ink)[#cells]],
)

#let course-note(
  main,
  detail: none,
  inset: (x: 16pt, y: 14pt),
  main_size: body-size * 1.3,
  detail_size: body-size * 0.65,
) = block(
  width: 100%,
  height: 1fr,
  // height: 100%,
  fill: warm,
  radius: 5pt,
  inset: inset,
)[
  #text(
    font: body-font,
    size: main_size,
    weight: 600,
    fill: accent-dark,
  )[
    #main
  ]
  #if detail != none {
    v(8pt)
    subtle-style(
      detail,
      size: detail_size,
    )
  }
]