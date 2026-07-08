Trabajo
Se nos entregaran 2 resultados de secuencias paired end(*) en un equipo illumina MiSeq de dos
librerias
-Cada libreria compuesta por dos fastq (2 por paciente)
-Corresponden a secuenciacion por amplicon(**) del exoma del gen pkd1 humano(***)
-se debe descargar secuencia de referencia de NCBI
Para hacerlo se debe usar ubuntu linux con:
-fastqc e igv (programas)
-linea de comandos (instalables y detalles en segundo parrafo materiales y metodos)(****)
*secuenciacion paired-end: una lectura desde un extremo de adn, otra lectura desde el otro
extremo del mismo adn
**secuenciacion por amplicon: fragmento de adn amplificado mediante pcr
***Dentro del adn se amplifico gen pkd1 porque ese es el de nuestro interes. Trabajaremos con
exones, esos fueron amplificados y secuenciados, intrones desechados
****practicamente todo el trabajo se trabaja escribiendo comandos, IGV es la única herramienta con
interfaz grafica para visualizar resultados
Entregable
-Informe: pdf
-cada que se avance en proceso hacer cuadro con reporte (lo que se hizo y comentarios)
Guia a trabajar
Reporte:
-portada
-introducción (dicho al final del documento)
-desarrollo (reportes, comandos, descripciones, respuestas preguntas, etc)
-conclusión
(Verse profesional)
Organizacion de directorios:
-Usar estructuras de control que mantengan orden ya que se pueden generar archivos muy
grandes
Crearemos directorio base y luego dentro irán los directorios dentro del directorio base:
1. DNAref: almacena DNA de referencia, link en pagina 3 (peso aprox descarga 900 mb).1.
2.
3.
4.
5.
6.
7.
Reporte (breve explicación de lo hecho).
RawReads: datos crudos obtenidos, se recomienda asignar links simbólicos(*) con nombres
abreviados(**)
FastQC_rawReads: almacena reportes fastqc de los datos crudos, los datos de la
secuenciación tienen problemas de calidad, hay que podarlos 2 veces (Se analizan datos con
fstqc y se podan con trimmomatic), luego hacer comparacion con los datos crudos, me
imagino que sera respondiendo las preguntas de la pagina 4. Reporte.
Trimmed_reads: almacena los datos podados, a los archivos ponerles nombres cortos e
intuitivos, que se identifique de que son. Correr los archivos nuevos(podados) en fastqc para
poder comparar los archivos crudos con los nuevos. Preguntas y reporte en ultimo parrafo
pagina 4.
FastQC_trimedReads: Almacena reportes de FastQC de datos podados
Aligned_reads: almacena los archivos de alineamiento hecho con las secuencias
almacenadas en Trimmed_reads, importante no proceder con el alineamiento hasta despues
que se haya hecho el indice(**). El resultante del alineamiento sera un archivo sam/bam y
este lo dirigimos al directorio Aligned_reads. El archivo BAM obtenido debe desplegarse en
IGV (****) (*****). Reporte y preguntas en pag 6.
Variant_calling: almacena variantes identificadas. Se debe crear archivo BCF(pileup)(******),
se realiza con comando(*******). Hay que procesar archivo bam y el genoma de referencia en
IGV. Almacenar archivo resultante (BCF) en directorio variant_calling. Con este archivo
resultante se debe realizar el variant calling(porfin), esto generara otro archivo BCF con las
variables identificadas. Llegados aca podemos podemos desplegar el ultimo archivo obtenido
en IGV para dar interpretación. Reporte y preguntas.
*links simbólicos: mismo concepto que acceso directo de windows
**para alineamiento, en el directorio DNAref crear indice del archivo fasta. Usar utilidad index de
bwa (info mas detallada primer parrafo pag. 5).
La indexación tarda mucho, a lo menos una hora con buen computador para el genoma humano
completo. Podemos usar comando time para que nos diga cuanto tiempo tomó.
***los archivos sam o bam se pueden transformar en el otro con un comando.
****Para cargar archivo en IGV hay que indexar IGV. Para indexarlo primero hay que ordenar el BAM
con un comando, luego se procede con indexación de IGV con otro comando(penúltimo párrafo 5
pagina)
*****El profesor insiste en seleccionar genoma de referencia adecuando en IGV, existe la posibilidad
de confundirnos y pasar a alinear nuestro archivo con algo no debido. En peor de los casos (ojala no
pase) hay que subir manualmente el fasta que queramos, link en primer parrafo pagina 6
******El profesor dice que tendremo un problema con el archivo BCF que crearemos, la solucion es
simple, una vez que lo creemos hay que descomprimirlo y volver a comprimirlo con el comando del
cuadro que aparece en el cuadro que esta entre pagina 6 y 7.
*******Ultimo parrafo pagina 6
