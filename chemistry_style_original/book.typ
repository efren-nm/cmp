// The book
#import "design.typ": *
#show: book-design

#set document(
  title: [Apuntes de Química II, GIEI],
)

#include "chapters/00-intro.typ"
#include "chapters/01-estructura-atomica.typ"
#include "chapters/02-enlace-quimico.typ"
// #include "chapters/03-elementos-aplicaciones.typ"
#include "chapters/03-elementos-aplicaciones_moderno.typ"

#bibliography("references.yml") <bibliografia>
