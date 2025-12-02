library(vegan)
library(ade4)
library(factoextra)
library(FactoMineR)
library(tidyverse)
library(plyr)
library(ape)
library(pls)
library(ggplot2)
library(broom)
library(glue)
library("writexl")

# j'officialise la colonne année dans pas PCoA
head(PCoA_Bio)
rownames(PCoA_Bio)
colnames(PCoA_Bio)[1] <- "Annee"
PCoA_Bio <- as.data.frame(PCoA_Bio)
rownames(PCoA_Bio) <- PCoA_Bio$Annee
PCoA_Bio$Annee <- NULL
head(PCoA_Bio)
rownames(PCoA_Bio)

# indice de dissimilarité de Bray
PCoA_Bio_Bray <- vegdist(PCoA_Bio, method = "bray")
PCoA_Bio_Bray
str(PCoA_Bio_Bray)
res_PCoA_Bio_Bray <- pcoa(PCoA_Bio_Bray)
# ça fonctionne

biplot(res_PCoA_Bio_Bray, plot.axes=1:2, dir.axis1 = -1)
# sur axe 1 : deux groupes diff entr 2011-2013 et 2017-2021 --> années éloignées 
# sur l'axe 2 départage les groupes 2010-2013 et 2014-2016, maybe shift dans la communauté ?
# structure de "fer à cheval" : à creuser

biplot(res_PCoA_Bio_Bray, plot.axes=2:3)
biplot(res_PCoA_Bio_Bray, plot.axes=c(1,3))
# beaucoup moins explicatifs

###################################################################

# Partie Cercle de corrélation

#Variables à standardiser si données quantitatives

PCoA_Ab_log_Bray_ST = apply(PCoA_Bio, 2, scale, center=TRUE, scale=TRUE)
corVar<-cor(PCoA_Ab_log_Bray$vectors,PCoA_Ab_log_Bray_ST)
corVar
PCoA_Ab_log_Bray_centr = apply(PCoA_Bio, 2, scale, center=TRUE, scale=TRUE)
corVar<-cor(PCoA_Ab_log_Bray$vectors,PCoA_Ab_log_Bray_centr)
corVar

corVar_b<-cor(res_PCoA_Bio_Bray$vectors, PCoA_Bio)


#Transposition matrice de corrélation
corVar_transpose = t(corVar_b)
corVar_transpose
biplot(res_PCoA_Bio_Bray, plot.axes=1:2, dir.axis1 = -1) #vérif que tout est bon = affirmatif

AbPCoA.axisX_Bray <- as.data.frame(res_PCoA_Bio_Bray$vectors)
Abvector.axisX <- as.data.frame(corVar_transpose)

#before espèces qui contribuent le plus

### ggplot avec sélection des espèces 
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

# sans les dates ? 
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




# écriture des % de variation sur les axes
res_PCoA_Bio_Bray
ABpe_brayX<-100*res_PCoA_Bio_Bray$values$Relative_eig
ABpe_brayX
per_brayX <- round(ABpe_brayX[1:2], digits=1) # round permet d'arrondir à un chiffre
per_brayX
library(glue)
labs <- c(glue("PCO 1 ({per_brayX[1]}%)"),
          glue("PCO 2 ({per_brayX[2]}%)"))

##############################################################
# je tente un truc pour les espèces qui contribuent le +
Abvector.axisX$contrib <- sqrt(Abvector.axisX$Axis.1^2 + Abvector.axisX$Axis.2^2)
seuil_contrib <- 0.50  # à ajuster si besoin
Abvector.axisX_top <- Abvector.axisX[Abvector.axisX$contrib > seuil_contrib, ]

### ggplot avec sélection des espèces 
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

# sans les dates ? 
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




# écriture des % de variation sur les axes
res_PCoA_Bio_Bray
ABpe_brayX<-100*res_PCoA_Bio_Bray$values$Relative_eig
ABpe_brayX
per_brayX <- round(ABpe_brayX[1:2], digits=1) # round permet d'arrondir à un chiffre
per_brayX
library(glue)
labs <- c(glue("PCO 1 ({per_brayX[1]}%)"),
          glue("PCO 2 ({per_brayX[2]}%)"))

#### Graphes accoles les uns aux autres... pour plus de lisibilité
library(cowplot)
library(gridExtra)
install.packages("ggforce")
library(ggforce)
library(ggrepel)

pe_BrayX<-100*res_PCoA_Bio_Bray$values$Relative_eig
per_BrayX <- round(pe_BrayX[1:2], digits=1) # round permet d'arrondir à un chiffre
per_BrayX
library(glue)
labs <- c(glue("PCO 1 ({per_BrayX[1]}%)"),
          glue("PCO 2 ({per_BrayX[2]}%)"))

# position des objects - points et textes superposes
objX<-ggplot() + theme_bw() + 
  coord_equal() +
  theme(aspect.ratio=1)+
  geom_text(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray))) +
  labs(
    x=labs[1], 
    y=labs[2],
  )
objX

# position des objects - avec fonction repel
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

#tracage des correlations entre les variables et les axes - superposition
indX<-ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  theme(aspect.ratio=1)+
  geom_text_repel(data=Abvector.axisX, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX)), color="red", alpha=0.8) +
  geom_segment(data = Abvector.axisX,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x=labs[1], 
    y=labs[2],
  )
indX
#tracage des correlations entre les variables et les axes - avec fonction repel
indXrepel<-ggplot() + theme_bw() +
  xlim(-1, 1) + ylim(-1, 1) +
  coord_equal() +
  theme(aspect.ratio=1)+
  geom_text_repel(data=Abvector.axisX, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX)), color="red", alpha=0.8) +
  geom_segment(data = Abvector.axisX,
               aes(x = 0, y = 0,
                   xend = Axis.1,
                   yend = Axis.2),
               arrow = arrow(length = unit(1/2, 'picas')),
               color="red", alpha=0.8) +
  geom_path(data=dat, aes(x,y))+
  labs(
    x=labs[1], 
    y=labs[2],
  )
indXrepel
#mise en page des deux graphiques
plot_grid(objX, indX, scale=1, labels=c("A", "B"), ncol = 2, nrow = 1)
#Avec fonction repel
plot_grid(objXpoint, indXrepel, scale=1, labels=c("A", "B"), ncol = 2, nrow = 1)
help(plot_grid)

#################################################
#Lignes de code pour remettre le nom des espèces si jamais
# 1er pour la version du graphique avec dates

geom_text(data=AbPCoA.axisX_Bray, aes(x=Axis.1, y=Axis.2, label=rownames(AbPCoA.axisX_Bray))) +
  geom_text(data=Abvector.axisX_top, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX_top)), color="red", alpha=0.8) +
  
#2ème sans le nom des dates
geom_text(data=Abvector.axisX_top, aes(x=Axis.1, y=Axis.2, label=rownames(Abvector.axisX_top)), color="red", alpha=0.8) +

  

