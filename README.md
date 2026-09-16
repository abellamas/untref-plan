# Plantilla LaTeX — Plan de Investigación

Implementación en LaTeX del formato exigido por la cátedra de Metodología de la
Investigación Científica de la carrera de Ingeniería de Sonido de la Universidad
Nacional de Tres de Febrero (UNTREF), definido en el documento
`Formato Plan de investigacion Modelo Rev. 7.docx`.

El objetivo es reproducir el formato del modelo original con precisión
verificable, de modo que el contenido pueda redactarse en LaTeX sin riesgo de
desvíos respecto de la consigna.

## Requisitos

| Componente | Detalle |
|---|---|
| Motor de compilación | LuaLaTeX o XeLaTeX. No compila con pdfLaTeX, dado que la clase emplea `fontspec` |
| Fuentes tipográficas | Times New Roman y Calibri, tomadas del sistema |
| Paquete adicional | `tex-gyre-math`, para la composición matemática con métricas de Times |

Instalación del paquete matemático:

```
mpm --install=tex-gyre-math     # MiKTeX
tlmgr install tex-gyre-math     # TeX Live
```

En sistemas donde Times New Roman o Calibri no estén disponibles, la clase
sustituye por TeX Gyre Termes y Carlito respectivamente, que son métricamente
equivalentes, y emite una advertencia durante la compilación. Si falta
`tex-gyre-math`, la clase informa la ausencia y continúa con la composición
matemática por defecto de LaTeX.

## Compilación

```
lualatex plan.tex
lualatex plan.tex
```

Se requieren dos pasadas para resolver las referencias cruzadas.

El contenido se redacta exclusivamente en `plan.tex`. La totalidad del formato
reside en `untref-plan.cls`, cuyas definiciones no requieren modificación.

## Estructura del repositorio

```
plan.tex            documento de trabajo
untref-plan.cls     definición del formato, con el origen de cada medida documentado
figuras/            logotipo institucional y figura de ejemplo
ejemplo-plan.pdf    salida de referencia para comparación
modelo/             documento original de la cátedra
doc/                guía de estilo APA de la cátedra
```

`plan.pdf` está excluido del control de versiones por tratarse de un archivo
generado en cada compilación. La salida de referencia versionada es
`ejemplo-plan.pdf`.

El archivo contenido en `modelo/` es material de cátedra de UNTREF y se incluye
únicamente como referencia del formato exigido.

## Especificación del formato

Las medidas se obtuvieron del XML interno del documento original
(`word/document.xml`, `word/styles.xml`, `word/numbering.xml`,
`word/theme/theme1.xml`) y se verificaron contra el PDF que produce Microsoft
Word al abrir ese mismo archivo. Las conversiones aplicadas son
twips ÷ 566,93 = cm, `w:sz` ÷ 2 = pt y EMU ÷ 360000 = cm.

| Elemento | Valor | Origen en el XML |
|---|---|---|
| Tamaño de hoja | A4 | `w:pgSz` 11906 × 16838 twips |
| Márgenes | superior e inferior 2 cm; izquierdo 3 cm; derecho 2 cm | `w:pgMar` 1134/1134/1701/1134 |
| Encabezado, pie y numeración de página | sin definir | ausencia de `header1.xml` y `footer1.xml` |
| Cuerpo de texto | 12 pt, justificado | `w:sz 24`, `w:jc both` |
| Sangría de primera línea | 0,63 cm | `w:ind w:firstLine="357"` |
| Interlineado | simple, sin espacio anterior ni posterior | ausencia de `w:spacing` |
| Títulos de nivel 1 | negrita 14 pt; numeración al margen; texto a 0,614 cm | `w:sz 28`, `w:ind left=348 hanging=360` |
| Títulos de nivel 2 | negrita 14 pt; numeración a 0,614 cm; texto a 1,376 cm | `w:ind left=780 hanging=432` |
| Viñetas | símbolo a 0,63 cm; texto a 1,259 cm | `abstractNum 1`, `w:ind left=714 hanging=357` |
| Epígrafes de figura | negrita y cursiva 10,5 pt, centrados, al pie de la figura | `w:sz 21`, `w:b`, `w:i`, `w:jc center` |
| Ecuaciones | centradas, con número a la derecha entre paréntesis | consigna incluida en el modelo |
| Diagrama de Gantt | 17 columnas, bordes de 0,5 pt, celdas marcadas con relleno `#D9D9D9` | tabla 2, `w:shd fill=d9d9d9` |
| Referencias bibliográficas | sangría francesa de 0,75 cm, justificado, 12 pt | `w:ind left=426 hanging=426` |

## Tipografía

El documento original **no declara fuente para el cuerpo de texto**. La
inspección del XML muestra que:

- los párrafos del cuerpo definen únicamente el tamaño (`w:sz 24` = 12 pt) y no
  contienen elementos `<w:rFonts>`;
- el estilo `Normal` no define propiedades de carácter;
- el bloque `docDefaults` sólo declara el idioma (`es-AR`);
- las 289 declaraciones de Calibri presentes en el documento corresponden a la
  carátula y a las tablas, no al cuerpo;
- el tema define Cambria para títulos y Calibri para cuerpo, pero ningún párrafo
  invoca esas definiciones mediante `w:asciiTheme`.

En consecuencia, la fuente del cuerpo queda determinada por la aplicación que
abre el archivo. Microsoft Word aplica Times New Roman, comportamiento
verificado sobre el documento original, y es la fuente que adopta esta
plantilla. La carátula emplea Calibri, única sección con la fuente declarada de
forma explícita.

La salida compilada incorpora las fuentes reales del sistema: el PDF resultante
embebe `TimesNewRomanPSMT` y sus variantes en el cuerpo, y `Calibri` en la
carátula.

### Diferencias de composición respecto de Word

La fuente es idéntica, pero la construcción del renglón difiere entre ambos
sistemas. Las causas son el algoritmo de justificación, que en LaTeX optimiza el
párrafo completo y en Word opera línea por línea; la separación en sílabas,
activada en LaTeX y desactivada por defecto en Word; y el interlineado simple,
que en Word equivale a aproximadamente 13,8 pt frente a los 14,5 pt de la clase
`article` a 12 pt.

La clase incluye, comentadas y documentadas, las dos directivas necesarias para
aproximar la composición a la de Word (`\setstretch{0.952}` y la desactivación
de la separación en sílabas). Se mantienen inactivas de forma predeterminada,
por cuanto la composición de LaTeX resulta tipográficamente preferible y
ninguna de las dos afecta el cumplimiento del formato especificado.

## Desviaciones deliberadas respecto del modelo

1. **Salto de página posterior a la carátula.** En el documento original, el
   título de la investigación queda al pie de la carátula como consecuencia del
   espaciado. En esta implementación la sección comienza en la página siguiente,
   junto con el nombre del investigador.
2. **Ancho del diagrama de Gantt.** Se reduce 0,06 mm respecto de los 16,17 cm
   del original, para que la tabla entre en la caja de 16 cm sin invadir el
   margen.
3. **Marco del logotipo.** La carátula del documento original presenta los
   bordes visibles de una tabla de maquetado de 1 × 2 alrededor del logotipo. Se
   replica para mantener la fidelidad al modelo. Para suprimirlo basta dejar
   únicamente la instrucción `\includegraphics` en la macro
   `\untref@encabezado` de `untref-plan.cls`.
4. **Composición de ecuaciones.** El modelo inserta la ecuación de ejemplo como
   imagen; esta plantilla la compone con `\begin{equation}`, lo que además
   satisface la consigna de emplear la misma fuente del texto.

## Citación y referencias

La norma aplicable es la establecida en la *Guía de estilo APA para citas y
referencias* de la cátedra, incluida en `doc/guia_APA.pdf`. La plantilla ofrece
dos procedimientos alternativos.

### Redacción manual

Las referencias se escriben dentro del entorno
`\begin{referencias} ... \end{referencias}`, una entrada por párrafo. El entorno
aplica la sangría francesa de 0,75 cm, el justificado y el cuerpo de 12 pt que
especifica el modelo, sin espacio adicional entre entradas.

### Archivo .bib con apacite (APA 6)

La sección 3 de la guía recomienda `apacite` para la composición en LaTeX. El
paquete permanece en su versión 6.03, de 2013, e implementa la sexta edición del
manual APA. Para habilitarlo:

```latex
\documentclass[apacite]{untref-plan}
...
\referenciasbib{referencias}   % lee referencias.bib
```

Compilación:

```
lualatex plan.tex
bibtex plan
lualatex plan.tex
lualatex plan.tex
```

Citas en el texto: `\citeA{clave}` para las narrativas y `\cite{clave}` para las
parentéticas, conforme a la guía. La opción conserva el formato del modelo
(título «Referencias.», sangría francesa de 0,75 cm y sin espacio entre
entradas) y sustituye el «y cols.» que `apacite` emplea en español por «et al.».

Esta modalidad permite compartir un mismo archivo `.bib` con otros documentos
del proyecto.

### Archivo .bib con biblatex-apa (APA 7)

`biblatex-apa` implementa la séptima edición del manual APA desde noviembre de
2019 y es la única alternativa actualizada a esa edición. Requiere `biber` como
procesador de bibliografía. Para habilitarlo:

```latex
\documentclass[biblatex]{untref-plan}
\bibliografia{referencias}     % en el preámbulo; lee referencias.bib
...
\referenciasbib                % en el cuerpo, donde va la lista
```

Compilación:

```
lualatex plan.tex
biber plan
lualatex plan.tex
lualatex plan.tex
```

Citas en el texto: `\textcite{clave}` para las narrativas y `\parencite{clave}`
para las parentéticas. En el archivo `.bib`, el campo `doi` se consigna sin la
dirección completa (`doi = {10.3390/ijerph15112392}`), a diferencia de `apacite`.

Diferencias observadas entre ambas rutas, con idéntico archivo `.bib`:

| Aspecto | apacite | biblatex-apa |
|---|---|---|
| Edición del manual | 6.ª | 7.ª |
| Tres o más autores, primera cita narrativa | lista todos los autores | «et al.» |
| Conjunción en la lista de referencias | «y» | «&» |
| Tesis | «(Tesis doctoral)» | «[Tesis doctoral]» |
| Procesador | `bibtex` | `biber` |

Ambas opciones conservan el título «Referencias.», la sangría francesa de
0,75 cm y la ausencia de espacio entre entradas que especifica el modelo.

### Requisitos de la guía que la plantilla no puede verificar

Los siguientes puntos dependen de la redacción y deben controlarse manualmente:

- se prefiere la cita narrativa, para atribuir con claridad la autoría de cada
  hallazgo;
- los estudios previos se describen en tiempo pasado;
- se consignan únicamente apellidos, sin iniciales ni títulos académicos, en las
  citas del texto;
- en la lista de referencias se enumeran todos los autores, sin recurrir a
  «et al.», con apellido seguido de iniciales;
- los nombres de revistas se escriben completos, sin abreviaturas;
- los títulos de artículos, libros y capítulos llevan mayúscula inicial
  únicamente en la primera palabra y en los nombres propios; los nombres de
  revistas, en cada palabra principal;
- las direcciones electrónicas remiten a la página oficial de la editorial o al
  DOI, y no a fuentes secundarias como ResearchGate, PubMed o JSTOR;
- toda referencia obtenida mediante herramientas automáticas requiere
  verificación humana contra la fuente original.

### Limitaciones conocidas de apacite

- `apacite` implementa APA 6: con tres o más autores lista todos los autores en
  la primera cita narrativa, mientras que APA 7 y la guía de la cátedra
  requieren «et al.» desde la primera mención. La instrucción `\shortcites` no
  corrige este comportamiento, de modo que tales citas deben redactarse
  manualmente.
- Con babel en español, `apacite` introduce una coma antes de la conjunción
  final en las citas narrativas de tres o más autores.

En caso de exigirse una correspondencia exacta con los ejemplos de la guía,
resulta preferible la redacción manual en el entorno `referencias`.
