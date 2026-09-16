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

## Referencias bibliográficas

Las referencias se redactan dentro del entorno
`\begin{referencias} ... \end{referencias}`, una entrada por párrafo, conforme a
las normas APA adoptadas por UNTREF
(<https://untref.edu.ar/raesta/normas-apa.php>). Este procedimiento garantiza
una salida idéntica a la del modelo.

Como alternativa puede emplearse `biblatex` con `style=apa` y un archivo `.bib`,
opción que facilita compartir la bibliografía con otros documentos del proyecto,
si bien introduce diferencias menores respecto del ejemplo provisto por la
cátedra.
