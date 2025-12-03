########################################################
# Analyse PCOA - Données annuelles de biomasse (sans les espèces rares)
# Nom : PCoA_BiomassWithoutRareSpecies.R
# Auteur : Clotilde GUERIN
# Date : 3 Décembre 2025
########################################################

##### Chargement des données ####
PCoA_Bio_WithoutRareSpecies <- read.csv("data/PCoA_Bio_WithoutRareSpecies.csv")

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
  geom_text_repel(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray)))+
  labs(
    x=labs[1], 
    y=labs[2],
  )->objXpoint
objXpoint 
