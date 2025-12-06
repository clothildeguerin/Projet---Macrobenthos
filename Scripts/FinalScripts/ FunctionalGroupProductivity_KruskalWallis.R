########################################################
# Description : Analyse statistique - Comparaison de la productivité (P/B),
#               entre les différents groupes trophiques identifiés,
#               sur l'ensemble de la période étudiée (2010-2022). 
# Nom : FunctionalGroupProductivity_KruskalWallis.R
# Auteur : Clothilde GUERIN 
# Date : 3 Décembre 2025

#### Session info
# R version 4.3.1 (2023-06-16)
# Platform: x86_64-conda-linux-gnu (64-bit)
# Running under: Ubuntu 22.04.5 LTS
#
# Matrix products: default
# BLAS/LAPACK: /shared/software/miniconda/envs/r-4.3.1/lib/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
#
# locale:
# [1] LC_CTYPE=en_US.UTF-8      
# [2] LC_NUMERIC=C              
# [3] LC_TIME=en_US.UTF-8       
# [4] LC_COLLATE=en_US.UTF-8    
# [5] LC_MONETARY=en_US.UTF-8   
# [6] LC_MESSAGES=en_US.UTF-8   
# [7] LC_PAPER=en_US.UTF-8      
# [8] LC_NAME=C                 
# [9] LC_ADDRESS=C              
# [10] LC_TELEPHONE=C            
# [11] LC_MEASUREMENT=en_US.UTF-8
# [12] LC_IDENTIFICATION=C   
#
# time zone: Europe/Paris
# tzcode source: system (glibc)
#
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets
# [6] methods   base
#
# other attached packages:
# [1] FSA_0.10.0
#
# loaded via a namespace (and not attached):
# [1] compiler_4.3.1    tools_4.3.1
# [3] rstudioapi_0.16.0
########################################################

#Chargement des données
PBDataFor_KruskallWallis_BoxPlot <- read.csv("Data/DataFunctionalGroupProductivity_KruskalWallis.csv", sep = ",")

#Chargement des librairies
library(FSA) #Pour effectuer Test de Dunn (dunnTest)

#### Représentation boxplot et test de Kruskal-Wallis ####
boxplot(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot,
        main = "Comparaison de la productivité entre les groupes trophiques",
        xlab = "Groupe trophique", ylab = "Productivité (en an-1)")

kruskal.test(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot)

#### Vérification des différences significatives entre les guildes trophiques - Test de Dunn avec correction de Holm ####
dunnTest(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot, method = "holm")