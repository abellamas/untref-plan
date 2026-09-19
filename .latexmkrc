# Configuracion de latexmk. Con este archivo en el directorio alcanza con
# correr  latexmk  a secas: usa LuaLaTeX, llama a biber cuando hace falta y
# deja TODO lo generado en build/, incluido el PDF.
#
#   latexmk           compila; el resultado queda en build/main.pdf
#   latexmk -pvc      recompila solo al guardar
#   latexmk -c        borra los auxiliares y deja el PDF
#   latexmk -C        borra tambien el PDF

# Sin esto, latexmk a secas intentaria compilar TODOS los .tex del directorio.
# Importa cuando el plan se parte en un archivo por seccion y el principal los
# carga con \input: los fragmentos no compilan por si solos.
@default_files = ('main.tex');

$pdf_mode   = 4;         # 4 = lualatex (1 seria pdflatex)
$out_dir    = 'build';
$bibtex_use = 2;         # corre biber y borra sus auxiliares al limpiar

# ejemplo-plan.pdf es la salida de referencia versionada y NO se genera aca:
# se actualiza a mano con  cp build/main.pdf ejemplo-plan.pdf

# Para entregar el PDF con otro nombre (renombra tambien los auxiliares, que
# igual viven en build/), descomentar y poner el nombre deseado.
# $jobname = 'MIC_PI_Apellido';
