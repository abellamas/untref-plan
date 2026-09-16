# Plan de Investigación — UNTREF, Ingeniería de Sonido (plantilla LaTeX)

Réplica en LaTeX de `Formato Plan de investigacion Modelo Rev. 7.docx`.

## Uso

```
lualatex plan.tex
lualatex plan.tex        # dos veces, por las referencias cruzadas
```

Escribí solo en `plan.tex`. El formato entero vive en `untref-plan.cls` y no hay
que tocarlo.

- **Motor:** LuaLaTeX o XeLaTeX (usa `fontspec` para tomar Times New Roman y
  Calibri del sistema). Con pdfLaTeX **no** compila.
- **Dependencias:** `tex-gyre-math` (ya instalado acá; en otra máquina:
  `mpm --install=tex-gyre-math` en MiKTeX, o `tlmgr install tex-gyre-math` en
  TeX Live). Si falta, la clase avisa y sigue con la matemática por defecto.
- **Fuera de Windows:** si no están Times New Roman ni Calibri, la clase cae
  sola a TeX Gyre Termes y Carlito, que son métricamente idénticas.

## De dónde salió cada medida

Todo está sacado del XML del `.docx` (`word/document.xml`, `styles.xml`,
`numbering.xml`, `theme1.xml`) y después verificado contra el PDF que produce
Word al abrir ese mismo archivo.

| Elemento | Valor | Origen |
|---|---|---|
| Hoja | A4 | `w:pgSz 11906 × 16838` twips |
| Márgenes | sup./inf. 2 cm, izq. 3 cm, der. 2 cm | `w:pgMar 1134/1134/1701/1134` |
| Encabezado / pie / folio | ninguno | no existen `header1.xml` ni `footer1.xml` |
| Cuerpo | Times New Roman 12 pt, justificado | `w:sz 24`, `w:jc both` |
| Sangría de 1.ª línea | 0,63 cm | `w:ind w:firstLine="357"` |
| Interlineado | simple, 0 pt antes/después | sin `w:spacing` |
| Títulos nivel 1 | negrita 14 pt, `1.` al margen, texto a 0,614 cm | `w:sz 28`, `w:ind left=348 hanging=360` |
| Títulos nivel 2 | negrita 14 pt, `1.1.` a 0,614 cm, texto a 1,376 cm | `w:ind left=780 hanging=432` |
| Viñetas | ● a 0,63 cm, texto a 1,259 cm | `abstractNum 1`, `w:ind left=714 hanging=357` |
| Epígrafes de figura | negrita + cursiva 10,5 pt, centrados, **al pie** | `w:sz 21`, `w:b`, `w:i`, `w:jc center` |
| Ecuaciones | centradas, número a la derecha entre paréntesis | consigna del propio `.docx` |
| Gantt | 17 columnas, bordes 0,5 pt, celdas marcadas `#D9D9D9` | tabla 2, `w:shd fill=d9d9d9` |
| Referencias | sangría francesa 0,75 cm, justificado, 12 pt | `w:ind left=426 hanging=426` |

### El detalle que casi se me pasa

El cuerpo es **Times New Roman, no Calibri**. Ningún párrafo del cuerpo declara
`<w:rFonts>`, el estilo `Normal` tampoco y `docDefaults` está vacío, así que
Word cae a su fuente por defecto (Times) y **no** a la `minorFont` del tema
(que sí es Calibri). Calibri aparece únicamente en la portada, donde los
párrafos sí la declaran explícitamente.

## Diferencias deliberadas con el .docx

1. **Salto de página después de la portada.** En el `.docx`, "Título de la
   Investigación" queda huérfano al pie de la carátula por accidente del
   espaciado. Acá arranca la página 2 junto con "Nombre del Investigador".
2. **Gantt 0,06 mm más angosto** que los 16,17 cm del original, para que entre
   en la caja de 16 cm sin invadir el margen.
3. **Marco del logo.** La carátula del `.docx` trae una tabla de maquetado de
   1×2 con los bordes visibles alrededor del logo (parece un descuido del
   autor, pero está en el modelo, así que lo repliqué). Para sacarlo, en
   `untref-plan.cls` dejá en `\untref@encabezado` solo el `\includegraphics`.
4. **Ecuación real en lugar de imagen.** El `.docx` inserta la ecuación de
   ejemplo como PNG; acá es `\begin{equation}`, que además cumple mejor la
   consigna ("número a la derecha, misma fuente del texto").

## Archivos

```
plan.tex           lo único que editás
untref-plan.cls    el formato, con cada medida comentada
figuras/           logo-untref.png + la figura de ejemplo
```

## Referencias

Van a mano dentro de `\begin{referencias} ... \end{referencias}`, una entrada
por párrafo, en APA (<https://untref.edu.ar/raesta/normas-apa.php>). Es lo que
garantiza que salgan idénticas al modelo.

Si preferís `.bib`, se puede cambiar por `biblatex` con `style=apa`, pero la
salida difiere en detalles menores del ejemplo del profesor.

## Contenido del repositorio

```
plan.tex            lo único que editás
untref-plan.cls     el formato, con cada medida comentada
figuras/            logo-untref.png + la figura de ejemplo
ejemplo-plan.pdf    salida de referencia, para comparar
modelo/             el .docx original de la cátedra del que se replicó el formato
```

El archivo de `modelo/` es material de cátedra de UNTREF y se incluye únicamente
como referencia del formato exigido. `plan.pdf` está en `.gitignore` porque se
regenera en cada compilación; la salida de referencia versionada es
`ejemplo-plan.pdf`.
