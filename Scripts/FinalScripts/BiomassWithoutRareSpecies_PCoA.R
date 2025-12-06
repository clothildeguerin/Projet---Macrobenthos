########################################################
# Description : Analyse PCOA - Comparaison des données annuelles 
#               de biomasse (sans espèces rares)
# Nom : BiomassWithoutRareSpecies_PCoA.R
# Auteur : Clothilde GUERIN (ORCID à ajouter mais encore pas créé)
# Date : 3 Décembre 2025

#### Session info : 
# R version 4.3.1 (2023-06-16)
# Platform: x86_64-conda-linux-gnu (64-bit)
# Running under: Ubuntu 22.04.5 LTS
# 
# Matrix products: default
# BLAS/LAPACK: /shared/software/miniconda/envs/r-4.3.1/lib/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
# 
# locale:
#   [1] LC_CTYPE=en_US.UTF-8      
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
#   [1] stats     graphics  grDevices utils     datasets 
# [6] methods   base     
# 
# other attached packages:
#   [1] ggrepel_0.9.5    ggforce_0.4.2    gridExtra_2.3   
# [4] cowplot_1.1.3    writexl_1.5.0    glue_1.7.0      
# [7] broom_1.0.6      pls_2.8-5        ape_5.8         
# [10] plyr_1.8.9       lubridate_1.9.3  forcats_1.0.0   
# [13] stringr_1.5.1    dplyr_1.1.4      purrr_1.0.2     
# [16] readr_2.1.5      tidyr_1.3.1      tibble_3.2.1    
# [19] tidyverse_2.0.0  FactoMineR_2.11  factoextra_1.0.7
# [22] ggplot2_3.5.1    ade4_1.7-22      vegan_2.6-6.1   
# [25] lattice_0.22-6   permute_0.9-7    FSA_0.10.0      
# 
# loaded via a namespace (and not attached):
#   [1] gtable_0.3.5         htmlwidgets_1.6.4   
# [3] tzdb_0.4.0           vctrs_0.6.5         
# [5] tools_4.3.1          generics_0.1.3      
# [7] parallel_4.3.1       sandwich_3.1-0      
# [9] fansi_1.0.6          cluster_2.1.6       
# [11] pkgconfig_2.0.3      Matrix_1.6-5        
# [13] scatterplot3d_0.3-44 lifecycle_1.0.4     
# [15] farver_2.1.2         compiler_4.3.1      
# [17] munsell_0.5.1        leaps_3.2           
# [19] codetools_0.2-20     htmltools_0.5.8.1   
# [21] pillar_1.9.0         MASS_7.3-60.0.1     
# [23] flashClust_1.01-2    DT_0.33             
# [25] multcomp_1.4-25      nlme_3.1-165        
# [27] tidyselect_1.2.1     digest_0.6.34       
# [29] mvtnorm_1.2-5        stringi_1.8.4       
# [31] splines_4.3.1        polyclip_1.10-6     
# [33] fastmap_1.2.0        grid_4.3.1          
# [35] colorspace_2.1-0     cli_3.6.3           
# [37] magrittr_2.0.3       survival_3.7-0      
# [39] utf8_1.2.4           TH.data_1.1-2       
# [41] withr_3.0.0          backports_1.5.0     
# [43] scales_1.3.0         timechange_0.3.0    
# [45] estimability_1.5.1   emmeans_1.10.3      
# [47] zoo_1.8-12           hms_1.1.3           
# [49] coda_0.19-4.1        mgcv_1.9-1          
# [51] rlang_1.1.4          Rcpp_1.0.12         
# [53] xtable_1.8-4         tweenr_2.0.3        
# [55] rstudioapi_0.16.0    R6_2.5.1            
# [57] multcompView_0.1-10 
########################################################

##### Chargement des données ####
PCoA_Bio_WithoutRareSpecies <- read.csv("Data/DataBiomassWithoutRareSpecies_PCoA.csv")

##### Chargement de la librairie ####
library(vegan) #PCoA et distance de Bray-Curtis
library(ade4) #extraire et visualiser résultats analyses multivariées
library(factoextra) #extraire et visualiser résultats analyses multivariées
library(FactoMineR) #extraire et visualiser résultats analyses multivariées
library(tidyverse) #facilite la manipulation, le nettoyage et la transformation
library(plyr) #diviser, appliquer et combiner des données
library(ape) #pour analyse pcoa
library(pls) #analyse de régression et de classification
library(ggplot2) #options graphiques
library(broom) #transformer les sorties statistiques en tibbles
library(glue) #incorporer dynamiquement des valeurs
library(writexl) #exporter des data frames
library(cowplot) #combinaison et l'alignement de plusieurs graphiques
library(gridExtra) #graphiques en grille
library(ggforce) #ajoutant des géométries et fonctionnalités spéciales
library(ggrepel) #empêche les étiquettes de se chevaucher

#### Mise en forme du jeu de donnée ####

# La colonne "année" doit être officialisée car elle n'est pas correctement définie dans le dataset d'origine
head(PCoA_Bio_WithoutRareSpecies)
rownames(PCoA_Bio_WithoutRareSpecies)
colnames(PCoA_Bio_WithoutRareSpecies)[1] <- "Annee"
PCoA_Bio_WithoutRareSpecies <- as.data.frame(PCoA_Bio_WithoutRareSpecies)
rownames(PCoA_Bio_WithoutRareSpecies) <- PCoA_Bio_WithoutRareSpecies$Annee
PCoA_Bio_WithoutRareSpecies$Annee <- NULL
head(PCoA_Bio_WithoutRareSpecies)
rownames(PCoA_Bio_WithoutRareSpecies)

#### Réalisation de l'Analyse en Coordonnées Principales (PCoA) ####

# On calcule une matrice de distance de Bray-Curtis à partir des données de biomasse
PCoA_Bio_Bray <- vegdist(PCoA_Bio_WithoutRareSpecies, method = "bray")
PCoA_Bio_Bray
str(PCoA_Bio_Bray)
res_PCoA_Bio_Bray <- pcoa(PCoA_Bio_Bray)

# Obtention des biplot, pour les trois premiers axes
biplot(res_PCoA_Bio_Bray, plot.axes=1:2, dir.axis1 = -1)
biplot(res_PCoA_Bio_Bray, plot.axes=2:3)
biplot(res_PCoA_Bio_Bray, plot.axes=c(1,3))

# Calcul de la matrice de corrélation puis transposition pour en faciliter la lecture
corVar_b<-cor(res_PCoA_Bio_Bray$vectors, PCoA_Bio_WithoutRareSpecies)
corVar_transpose = t(corVar_b)
corVar_transpose

# Convertir les axes et la matrice de corrélation en data.frames pour faciliter leur utilisation dans les graphiques
AbPCoA.axisX_Bray <- as.data.frame(res_PCoA_Bio_Bray$vectors)
Abvector.axisX <- as.data.frame(corVar_transpose)

#### Représentations graphique ####

### 1ère possibilité : considérer l'ensemble des espèces

circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}
dat <- circleFun(c(0,0),2,npoints = 360)

ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  geom_text(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray))) +
  geom_text(data=Abvector.axisX, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX)), color="red", alpha=0.8) +
  geom_segment(data = Abvector.axisX,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x= "Axe 1", 
    y= "Axe 2",
    title = "PCoA réalisée à partir du coefficient de BC, sur données log_transformées, CORRELATION")

# Enlever les dates pour alléger le cercle de corrélation obtenu
ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  geom_text(data=Abvector.axisX, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX)), color="red", alpha=0.8) +
  geom_segment(data = Abvector.axisX,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x= "Axe 1", 
    y= "Axe 2",
    title = "PCoA réalisée à partir du coefficient de BC, sur données log_transformées, CORRELATION")

# Extraction des pourcentages de variation expliqué par les axes 
res_PCoA_Bio_Bray
ABpe_brayX<-100*res_PCoA_Bio_Bray$values$Relative_eig
ABpe_brayX

### 2ème possibilité : Appliquer un seuil de contribution (ici 0.6, choisi arbitrairement pour limiter la surcharge graphique)
Abvector.axisX$contrib <- sqrt(Abvector.axisX$Axis.1^2 + Abvector.axisX$Axis.2^2)
seuil_contrib <- 0.60
Abvector.axisX_top <- Abvector.axisX[Abvector.axisX$contrib > seuil_contrib, ]

circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}
dat <- circleFun(c(0,0),2,npoints = 360)

ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  geom_text(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray))) +
  geom_text(data=Abvector.axisX_top, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX_top)), color="red", alpha=0.8) +
  geom_segment(data = Abvector.axisX_top,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x= "Axe 1", 
    y= "Axe 2",
    title = "PCoA réalisée à partir du coefficient de BC, sur données log_transformées, CORRELATION")

# Représentation graphique sans étiquettes (sans espèces et sans dates), prévue pour ajouter les légendes manuellement
ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  
  geom_segment(data = Abvector.axisX_top,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x= "Axe 1", 
    y= "Axe 2",
    title = "PCoA réalisée à partir du coefficient de BC, sur données log_transformées, CORRELATION")

# Extraction des pourcentages de variation expliqués par les axes
res_PCoA_Bio_Bray
ABpe_brayX<-100*res_PCoA_Bio_Bray$values$Relative_eig
ABpe_brayX

### Projection finale des années sur le plan factoriel 1 : 2

ggplot() + theme_bw() + 
  coord_equal() +
  theme(aspect.ratio=1)+
  geom_point(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray)))+
  geom_text_repel(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray)))->objXpoint
# I comment the error, since "labs" do not exist
#  +
#  labs(
#  x=labs[1], 
#  y=labs[2],)

objXpoint 
