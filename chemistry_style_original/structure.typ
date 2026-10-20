//------------------------------------------------------------
// The book hierarchy lives here.
// Chapter numbers are Roman. Section numbers are Arabic.
//------------------------------------------------------------

#let ch0 = (
  index: 0,
  number: [0],
  title: [Introducción],
  subtitle: [Presentación de la asignatura y guía de uso de los apuntes],
  references: none,
)

#let sec0_1 = (
  number: 1,
  title: [Objetivo de la asignatura],
  reference: [Tema I · diap. 3–20],
)

#let sec0_2 = (
  number: 2,
  title: [Notas importantes sobre la asignatura],
  reference: [Tema I · diap. 3–20],
)

#let sec0_3 = (
  number: 3,
  title: [Tabla de contenido],
  reference: [Tema I · diap. 3–20],
)

#let ch1 = (
  index: 1,
  number: [I],
  title: [Estructura atómica y propiedades periódicas],
  subtitle: [De la teoría atómica a la estructura electrónica y las tendencias periódicas],
  references: [
  // #cite(<casabo>)
    #cite(
      <casabo>,
      form: "full",
      style: "nature"
    )
    #cite(
      <burns-fundamentals>,
      form: "full",
      style: "nature"
    )
  ],
)

#let sec1_1 = (
  number: 1,
  // title: [La teoría atómica],
  title: [#text(size: 0.5em, style: "italic", weight: 200)[(muy)] Breve historia de la teoría atómica],
  reference: [Tema I · diap. 3–20],
)
#let sec1_2 = (
  number: 2,
  title: [Descripción cuántica del átomo],
  reference: [Tema I · diap. 21–45],
)
#let sec1_3 = (
  number: 3,
  title: [Configuración electrónica y tabla periódica],
  reference: [Tema I · diap. 46–69],
)
#let sec1_4 = (
  number: 4,
  title: [Propiedades periódicas],
  reference: [Tema I · diap. 70–87],
)

#let ch2 = (
  index: 2,
  number: [II],
  title: [Enlace químico],
  subtitle: [Del origen energético del enlace a las interacciones que determinan la estructura de la materia.],
  references: [
    #cite(
      <casabo>,
      form: "full",
      style: "nature"
    )
    // #cite(
    //   <burns-fundamentals>,
    //   form: "full",
    //   style: "nature"
    // )
  ],
)

#let sec2_1 = (
  number: 1,
  title: [Introducción al enlace químico],
  reference: [Tema II · Introducción al enlace · diap. 1–6],
)
#let sec2_2 = (
  number: 2,
  title: [Enlace iónico],
  reference: [Tema II · Enlace iónico · diap. 7–21],
)
#let sec2_3 = (
  number: 3,
  title: [Enlace covalente],
  reference: [Tema II · Enlace covalente · diap. 1–50],
)
#let sec2_4 = (
  number: 4,
  title: [Enlace metálico y teoría de bandas],
  reference: [Tema II · Enlace metálico · diap. 1–10],
)
/* #let sec2_5 = (
  number: 5,
  title: [Sólidos covalentes y naturaleza del enlace],
  reference: [Tema II · Sólidos · diap. 11–14],
) */
#let sec2_5 = (
  number: 5,
  title: [Fuerzas intermoleculares],
  reference: [Tema II · Fuerzas intermoleculares · diap. 15–37],
)

#let ch3 = (
  index: 3,
  number: [III],
  title: [Elementos químicos y aplicaciones],
  subtitle: [De la química descriptiva al material funcional: interés para la ingeniería.],
  references: [
    #cite(
      <shriver-inorganica-v2-enlace>,
      form: "full",
      style: "nature"
    )
  ],
)

#let sec3_1 = (
  number: 1,
  title: [Grupo 18: gases nobles],
  reference: [Tema III · Parte I · diap. 2–9],
)
#let sec3_2 = (
  number: 2,
  title: [Hidrógeno],
  reference: [Tema III · Parte I · diap. 10–24],
)
#let sec3_3 = (
  number: 3,
  title: [Grupo 14: Carbono y silicio],
  reference: [Tema III · Parte I · diap. 25–50],
)
#let sec3_4 = (
  number: 4,
  title: [Grupo 15: Nitrógeno y fósforo],
  reference: [Tema III · Parte II · diap. 2–29],
)
#let sec3_5 = (
  number: 5,
  title: [Grupo 16: Oxígeno y azufre],
  reference: [Tema III · Parte III · diap. 2–18],
)
#let sec3_6 = (
  number: 6,
  title: [Grupo 17: Halógenos],
  reference: [Tema III · Parte III · diap. 19–37],
)

#let chX = (
  index: 4,
  number: [X],
  title: [Ejercicios],
  subtitle: [Ejercicios para evaluación continua],
  references: none,
)