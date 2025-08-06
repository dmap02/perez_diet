# Diet-responsive genetic determinants of intestinal colonization in the yeast _Candida albicans_

---

## Overview

This repository contains all code, data, and documentation necessary to reproduce the microbiome analysis conducted for this study.

Title: Diet-responsive genetic determinants of intestinal colonization in the yeast _Candida albicans_

Musfirat Shubaita1,2, Mazen Oneissi1, Elena Lindemann-Pérez1, Anne-Marie Krachler1,2, Cecilia Fadhel Alvarez1,2, Diana M. Proctor1,2, and J. Christian Pérez1,2*

Affiliations: 1 Department of Microbiology and Molecular Genetics, McGovern Medical School, The University of Texas Health Science Center at Houston, Houston, USA
2 Graduate School of Biomedical Sciences, The University of Texas MD Anderson Cancer Center UTHealth Houston, Houston, USA

Correspondence: Dr. J. Christian Perez
                E-mail: jose.c.perez@uth.tmc.edu
                Phone: +1 (713)500-5432
                Fax: +1 (713)500-5499
                
Bash scripts were optimized with the help of chatGPT

Keywords: 

Dietary components influence microbial composition in the digestive tract. Although often viewed as energy sources, dietary components are likely to shape microbial determinants of intestinal colonization beyond metabolism. Here, we report that a dietary long-chain fatty acid enhances the yeast Candida albicans colonization of the murine gut partly by eliciting modifications to the fungal cell surface. Mice fed an oleic acid-rich diet were readily colonized by C. albicans and exhibited higher fungal load in feces compared to rodents fed an isocaloric control diet. Surprisingly, β-oxidation, a catabolic process to break down fatty acids for energy production, was dispensable for C. albicans to colonize the high oleic acid diet-fed mice. 16S rRNA analysis detected rather modest differences in the bacterial communities between control and oleic acid-rich diets. We identified SOK1 as an oleic acid-induced kinase that dictates cell wall mannan exposure and binding to intestinal mucin under anaerobic conditions. Furthermore, oleic acid induced the expression of several C. albicans transcription factors that positively regulate intestinal colonization via remodeling of the fungal cell surface. We posit that in environments largely devoid of oxygen like the large intestine, dietary oleic acid favors a C. albicans cell surface configuration that enhances gut occupation.

---

## Experimental Design

- **Sample Type**: Mus musculus feces
- **Timepoints**: T1 = 1 day before diet introduction; T2 = 6 days after diet introduction and 1 day before Candida albicans gavage; T3 = 10 days after Candida albicans gavage.
- **Groups**: Control (AIN-93G) diet vs FattyAcid (isocaloric high-oleic safflower oil) diet. Groups 1 and 2 (G1, G2) = T1; G3 and G4 = T2; G5 and G6 = T3. 
- **Sequencing Platform**: Illumina NovaSeq 6000
- **Target Region**: 16S rRNA sequencing of regions V3-V4
- **Primers Used**: oligos 341F and 806R

---


## Repository Structure

- `perez_diet/`
  - `Code` - Microbiome analysis markdown
    - `microbiome_analysis_cleaned_files/figure-html/` - Plots
  - `Figures/` - All figures
  - `databases/` - GTDB and RefSeq database files
  - `data/` – Raw and processed input data
    - `raw/` - Raw reads
  - `databases/` - Databases used for taxonomy analysis
  - `metadata/` – Sample metadata file (CSV)
  - `rds_objects/` – Saved RDS files (phyloseq objects)
  - `tables/` - Read tracking and BLAST tables for confusion matrix
  - `rmarkdown/` – Main analysis notebooks (Rmds)
  - `scripts/` – Helper R scripts for each task
  - `CITATIONS.md` - Citations for tutorials and databases
  - `LICENSE.txt` - MIT License
  - `LICENSE_DATA_CC_BY_4.0.txt` - Creative Commons Attribution 4.0 International Public License
  - `README.md` – This file


---

## Getting Started

### Install Required Packages

Use the provided script:

```r
source("scripts/install_packages.R")

# Or install manually:
install.packages(c("dada2", "phyloseq", "ggplot2", "vegan", "decontam", "microbiome", "tidyverse", "readxl", "dplyr", "tidyr", "VennDiagram"))
```


### Data Input

Raw data location: data/raw/

Metadata file: metadata/metadata.csv

- Ensure that your files follow this naming convention:

  - Casava-style sample naming format

  - Format:
    - SAMPLENAME_R1_001.fastq  # Forward reads
    - SAMPLENAME_R2_001.fastq  # Reverse reads

  - This naming convention ensures compatibility with DADA2’s filterAndTrim() and QIIME 2’s CasavaPairedEndFastqManifestPhred33V2 import type.


## Analysis Pipeline

Each step of the analysis is documented as a separate R Markdown file in the rmarkdown/ folder:

Run them in order using:
```r
rmarkdown::render("rmarkdown/"markdown_name.Rmd")
```

## Output

- All plots and tables are saved in the results/ folder.

- Final .rds files are in rds_objects/, including:

- ps_gtdb.rds – Phyloseq object with GTDB taxonomy

- ps_refseq.rds – Phyloseq object with RefSeq taxonomy

- seqtab.rds – DADA2 sequence table

- taxa.rds – DADA2 taxonomy assignment


## Dependencies

- R version ≥ 4.2.0
- DADA2 version ≥ 1.34.0


## Required R packages

You can install all dependencies using:

```r
source("scripts/install_packages.R")

# Or install manually:
install.packages(c(
  "dada2", "phyloseq", "vegan", "decontam", "microbiome",
  "ggplot2", "tidyverse", "readr", "knitr", "patchwork",
  "RColorBrewer", "gridExtra", "data.table", "reshape2"
))

# Optional: BiocManager::install("dada2") if not from CRAN.
```


## Databases Used

| Database Name | Description | Source | Version | Link |
|---------------|-------------|--------|---------|------|
| **RefSeq-RDP v2** | 16S rRNA species-level reference database for DADA2 taxonomy assignment | Zenodo | 2021 | [RefSeq-RDPv2_16S_species.fa](https://zenodo.org/record/4735821) |
| **GTDB SSU r202** | Full-length small subunit (SSU) sequences with full taxonomy from GTDB | Zenodo | GTDB release 202 | [GTDB_bac120_arc122_ssu_r202_fullTaxo.fa](https://zenodo.org/record/2541239) |

These databases were used to assign taxonomy via DADA2’s `assignTaxonomy()` and `addSpecies()` functions. They were downloaded directly from Zenodo and are included in the repository under `databases/` (not tracked by GitHub due to size).


## Tutorials and Pipelines Followed

- **DADA2 Illumina Pipeline**  
  [https://benjjneb.github.io/dada2/tutorial.html](https://benjjneb.github.io/dada2/tutorial.html)  
  For filtering, denoising, merging, chimera removal, and taxonomy assignment.

- **Phyloseq Analysis Pipeline**  
  [https://joey711.github.io/phyloseq/](https://joey711.github.io/phyloseq/)  
  Used for integrating taxonomy, OTU tables, and metadata into a single object and for visualizing diversity metrics, ordinations, and taxonomic composition.

- **Breakaway diversity hypothesis testing vignette**  
  [https://adw96.github.io/breakaway/articles/diversity-hypothesis-testing.html](https://adw96.github.io/breakaway/articles/diversity-hypothesis-testing.html)  
  Used for modeling and comparing alpha diversity between treatment groups using `breakaway` and `betta()`.


## Reproducibility Notes

All scripts are designed to run on R >= 4.2.0

Tested on Windows 11 Education and MacOS Sequoia 16.2

- Memory: ≥ 8GB RAM recommended for DADA2 denoising

Random seeds are set where applicable

Filenames and metadata assumed to be UTF-8 encoded


# Author and Contact

Cecilia Fadhel Alvarez

Department of Microbiology and Molecular Genetics, McGovern Medical School, University of Texas Health Science Center at Houston

cecilia.m.fadhelalvarez@uth.tmc.edu | fadhel562@gmail.com

Date Last Updated: 6/23/2025


# Licenses and Citations

- **Code and analysis scripts**: MIT License (`LICENSE`)
- **Data, figures, and outputs**: CC BY 4.0 License (`LICENSE_DATA_CC_BY_4.0.txt`)
- **Citations**: [CITATIONS.md](./CITATIONS.md)


# Acknowledgments

Dr. J. Christian Perez

Dr. Diana Proctor

NIAID (The National Institute of Allergy and Infectious Diseases) R01AI175081: Fungal regulatory systems directing mammalian host colonization. Grantee: Jose Christian Perez, PhD
