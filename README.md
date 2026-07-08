# Pipeline de Análisis Bioinformático: Secuenciación de Exoma del Gen PKD1 Humano

Este repositorio contiene las pautas, el flujo de trabajo y la organización para el análisis bioinformático de secuencias obtenidas mediante secuenciación de exomas dirigidos (amplicón) del gen humano **PKD1**. 

El análisis se realiza sobre lecturas de tipo *paired-end* generadas en una plataforma Illumina MiSeq para dos librerías (dos pacientes distintos, con dos archivos FASTQ por paciente).

---

## 🛠️ Requisitos del Sistema y Software

El desarrollo del pipeline se realiza sobre el sistema operativo **Ubuntu Linux** utilizando la línea de comandos y las siguientes herramientas:

*   **FastQC**: Control de calidad de lecturas crudas y procesadas.
*   **Trimmomatic**: Poda y filtrado de secuencias de baja calidad o adaptadores.
*   **BWA (Burrows-Wheeler Aligner)**: Alineamiento de lecturas contra el genoma de referencia.
*   **Samtools / BCFTools**: Procesamiento de alineamientos (conversión SAM/BAM, ordenamiento, indexación) y llamado de variantes (Variant Calling).
*   **IGV (Integrative Genomics Viewer)**: Herramienta visual con interfaz gráfica para la inspección y validación del alineamiento y las variantes.

> [!NOTE]
> Prácticamente todo el flujo de trabajo se ejecuta a través de la terminal de comandos. IGV es la única herramienta con interfaz gráfica que utilizaremos.

---

## 📁 Organización de Directorios

Es fundamental mantener una estructura limpia y ordenada debido al gran tamaño de los archivos generados durante el análisis. Se recomienda la siguiente estructura dentro del directorio raíz:

```text
Pipeline-Analisis/
├── DNAref/                 # Secuencia de referencia del genoma (NCBI) e índices
├── RawReads/               # Enlaces simbólicos a los datos crudos (FASTQ) con nombres cortos
├── FastQC_rawReads/        # Reportes iniciales de calidad (FastQC) de datos crudos
├── Trimmed_reads/          # Lecturas podadas/filtradas (Trimmomatic) con nombres intuitivos
├── FastQC_trimmedReads/    # Reportes de calidad (FastQC) de datos podados
├── Aligned_reads/          # Archivos de alineamiento (SAM/BAM) e índices
└── Variant_calling/        # Archivos de llamado de variantes (BCF/VCF)
```

### Detalle de Directorios y Recomendaciones

1.  **`DNAref/`**
    *   Almacena el ADN de referencia descargado del NCBI (tamaño aproximado de descarga: ~900 MB).
    *   Aquí se debe generar el índice de BWA antes de proceder al alineamiento.
2.  **`RawReads/`**
    *   Almacena las lecturas crudas. Se recomienda utilizar **enlaces simbólicos** (`ln -s`) para no duplicar espacio en disco y usar nombres abreviados.
3.  **`FastQC_rawReads/`**
    *   Almacena los reportes generados por FastQC de las lecturas crudas.
    *   *Nota*: Dado que los datos crudos suelen presentar problemas de calidad, se requerirá podar las lecturas.
4.  **`Trimmed_reads/`**
    *   Almacena los archivos resultantes tras la poda con Trimmomatic. Asignar nombres cortos y claros.
5.  **`FastQC_trimmedReads/`**
    *   Almacena los reportes FastQC de los archivos podados para su posterior comparación con los reportes crudos.
6.  **`Aligned_reads/`**
    *   Almacena los archivos SAM/BAM de alineamiento contra la referencia.
7.  **`Variant_calling/`**
    *   Almacena los archivos BCF/VCF generados durante el proceso de detección de variantes.

---

## 🚀 Flujo de Trabajo (Pipeline) Paso a Paso

### 1. Preparación de la Referencia y Generación del Índice
Antes del alineamiento, se debe descargar el archivo FASTA de referencia e indexarlo usando `bwa index` en la carpeta `DNAref/`.

> [!WARNING]
> La indexación del genoma humano completo es un proceso computacionalmente costoso y puede tardar una hora o más. Se aconseja anteceder el comando con `time` para medir la duración (ej. `time bwa index ...`).

### 2. Control de Calidad Inicial
*   Crear accesos directos (enlaces simbólicos) en `RawReads/`.
*   Ejecutar `fastqc` en la carpeta `FastQC_rawReads/` para evaluar la calidad inicial de las lecturas crudas.

### 3. Poda y Filtrado de Lecturas
*   Aplicar `trimmomatic` para eliminar adaptadores y lecturas de baja calidad (usualmente se realiza en dos etapas de ajuste de parámetros).
*   Correr `fastqc` sobre los nuevos archivos podados y guardarlos en `FastQC_trimmedReads/`.
*   Comparar la calidad antes y después de la poda para responder las preguntas de la guía (Pág. 4).

### 4. Alineamiento contra el Genoma de Referencia
*   Realizar el alineamiento de las lecturas de `Trimmed_reads/` usando BWA. El resultado será un archivo SAM o BAM.
*   **Preparación para IGV**:
    1.  Convertir el archivo si es necesario (SAM a BAM).
    2.  Ordenar el archivo BAM por coordenadas.
    3.  Indexar el archivo BAM ordenado (`samtools index`) para habilitar su visualización en IGV.
*   Cargar el BAM en IGV para la inspección visual.

> [!IMPORTANT]
> **Cuidado en IGV**: Asegúrese de seleccionar el genoma de referencia adecuado en IGV para evitar confusiones de alinear su archivo con algo no debido. De ser necesario, cargue manualmente el archivo FASTA descargado (consulte la Pág. 6 de la guía).

### 5. Llamado de Variantes (Variant Calling)
1.  **Generar el archivo Pileup (BCF)**: Procesar el BAM y la referencia para generar un archivo intermedio BCF.
2.  **Variant Calling**: Procesar el archivo BCF para identificar variantes genéticas finales (generando un nuevo archivo BCF con las variantes identificadas).
3.  **Visualización**: Cargar las variantes obtenidas en IGV junto con los alineamientos para su interpretación final.

> [!TIP]
> Si experimenta problemas de formato con el archivo BCF intermedio, la solución recomendada consiste en descomprimirlo y volver a comprimirlo usando los comandos específicos provistos en la guía (cuadro entre las páginas 6 y 7).

---

## 📝 Estructura del Informe Final (Entregable)

El informe entregable debe ser un archivo en formato **PDF** con presentación profesional, estructurado de la siguiente manera: https://docs.google.com/document/d/1cOYECL9TNl2Zg1J__e90SG-R6gG2Y0AuW-99RRBbttI/edit?usp=sharing

1.  **Portada**: Datos de identificación del proyecto y autores.
2.  **Introducción**: Introducción teórica y objetivos (descritos al final de la guía de trabajo).
3.  **Desarrollo**:
    *   Bitácora detallada del procedimiento.
    *   Comandos exactos ejecutados en cada etapa.
    *   Tablas/cuadros de reporte del progreso de cada etapa (con descripción de lo realizado y comentarios).
    *   Respuestas a las preguntas formuladas a lo largo de la guía.
4.  **Conclusión**: Resumen de los hallazgos y experiencia obtenida.

---

## 📖 Glosario de Conceptos Clave

*   **Secuenciación Paired-End**: Técnica donde se lee un fragmento de ADN desde ambos extremos (R1 y R2), facilitando un alineamiento más preciso.
*   **Secuenciación por Amplicón**: Enfoque de secuenciación dirigida donde se amplifican regiones específicas (en este caso, los exones del gen PKD1) mediante PCR antes de secuenciar, descartando los intrones.
*   **Enlaces Simbólicos**: Accesos directos a nivel de sistema de archivos en Linux que permiten apuntar a archivos grandes ubicados en otros directorios sin duplicar el espacio ocupado.
*   **Indexación**: Proceso que crea un índice de acceso rápido para el genoma de referencia o los archivos BAM, acelerando significativamente los procesos de alineamiento y visualización en IGV.
