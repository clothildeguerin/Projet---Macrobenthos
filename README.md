**/!\ NE PAS FAIRE "VISUAL" car change la structure**
# FAIRisation d'un projet de stage de Master 1 _"Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"_
## I- Introduction 
### 1) Description du projet 
Les pressions anthropiques croissantes perturbent le fonctionnement des
écosystèmes côtiers. Suite à la marée noire de l’Amoco Cadiz en 1978, la
station Pierre Noire (baie de Morlaix) fait l’objet d’un suivi à long
terme de sa communauté macrobenthique. La production secondaire, mesurée
ou modélisée, est un bon indicateur de l’état écologique d’une
communauté. Toutefois, cette mesure n’a jamais été appliquée en routine
sur ce site. Dans le cadre de cette étude, la production secondaire a
été estimée en utilisant le modèle de Brey. Ce modèle, basé sur un
calcul par réseau de neurones, permet d’estimer la production secondaire
à partir de diverses variables écologiques.

Problématique de l'étude : quelle est la relation entre l’évolution de la production secondaire et
les changements de structure de la communauté de Pierre Noire ?

Objectifs de ce stage : 
- 1 : Compléter le suivis et analyses sur structure + fonctionnement de la communauté macrobenthique de Pierre Noire via l'estimation de la production secondaire
- 2 : Relier les variations de PS à celle de la structure de la communauté 
- 3 : Estimer la contribution des groupes taxonomiques + guildes à la PS
- Objectif additionnel : Comparer les P/B calculés par différents modèles à des valeurs in situ

De nombreux fichiers, scripts, analyses sont issues de ce genre de projet mais pourraient être intéressantes à réutiliser pour de futurs suivis ou comparaisons, que ce soit par la stagiaire, l'encadrant ou d'autres chercheurs du monde entier.
Ainsi, il est nécessaire que l'étude soit reproductible par tous, le plus rapidement possible.
Cela est possible grâce à l'utilisation d'une démarche FAIR.

### 1) Rappels de ce qu'est une démarche FAIR
#### a) F
#### b) A
#### c) I
#### d) R

## II- Etat initial
Dans cette partie nous décrivons l'état initial des données non fairisé juste après le
stage de Master 1 de Clothilde Guerin (Année universitaire 2024-2025).

### 1) Données d'entrée
Pour répondre aux objectifs, les fichiers Excels fournis au départ du stage sont les suivants : 
- "pn-2010-2022_compil-abundance_biomasses_harm_iso" : Abondances et biomasses individuelles mars et octobre tous les ans
entre 2010 et 2022 
- "FC-PN-77-07_AD" : Matrice de traits fonctionnels (incomplète) 
- "ProductivityANN01" : Macroexcel Brey (à mettre sur github car standard) 

**Les Dataset initiaux utilisés sur le logiciel Rstudio n'étaient pas nommés de manière claire et compréhensible par tous.**
Tableau biomasse exemple (sous forme de chunck où on colle avec TABulations)
--> Pas de métadonnées 

### 2) Organisation de l'espace de travail
``` 
├── M1 Sciences de la Mer 
│   └── Stage Roscoff 
│       └── Articles stage 
│           └── Articles de référence
│           └── différentes versions du rapport de stage et des présentations
│       └── Data stage
│           └── Résultats et graphique 
│               └── fichiers pdf des résultats
│               └── images des graphiques
│           └── Tableau Brey (Taxo + abiotique)
│               └── “FC-PN-77-07-AD"
│               └── “Tableau data input Brey (ANN)”
│               └── taxonomy-PN-77-07.xls
│               └── “Coding"
│           └── Fichiers et scripts PCoA ACP R
│               └── PCoA_Bio_wthrare
│               └── Cor_TProd
│               └── Cor_BioProdg_Somme
│               └── autres cripts d'exploration des données
│           └── Comparaison modèles empiriques
│               └── Images de formules issues des articles
│               └── Tableau excel avec calculs pour comparer les méthodes
```
L'organisation de l'espace de travail n'était pas si mal mais il manque de structuration et les noms de fichiers ne sont pas explicites.

### 3) Explication des analyses
Absente.
Ce README ne faisait pas partie des documents initiaux donc il n'y a pas d'explications des analyses, cela sera fait dans la partie 2.3.machin. 

### 4) Données intermédiaires

### 5) Scripts initiaux
Voici un exemple de script non FAIRisé (extrait du script "") : 

```
library(vegan)
... 
library("writexl")

# j'officialise la colonne année dans pas PCoA
head(PCoA_Bio_wthrare)
rownames(PCoA_Bio_wthrare)
...
# je tente un truc pour les espèces qui contribuent le +
...
```
Des commentaires sont présents mais souvent personnalisés, et les explorations / tests effectués n'ont pas été retirés, ce qui réduit la compréhension.
Il manque également la première description : le but du script, la personne l'ayant écrit à quelle date et avec quelles versions. 
Le chargement des données intermédiaires est absent (qui était fait manuellement à chaque fois).


## III- FAIRisation 
Dans cette deuxième partie nous indiquons les axes d'améliorations afin de FAIRiser la structure, les métadonnées et les analyses.
Ce présent document est une première étape dans notre démarche pour rendre FAIR ce travail. 
Le dernier objectif du stage (comparer litterature) nous a paru difficile à fairiser. 

### 1) Traçage des données initiales 
- PID de la zone
- PID de la station PN 
- PID SOMLIT - PID des auteurs (Sarah
Bureau) 
- PAS FAIRISABLE : Il manque les sources de la matrice de traits
fonctionnels, a été transmise telle quelle, a été complétée sans non plus
ajouter les sources au fur et à mesure, n'a pas indiqué les endroits qui
ont été estimés si rien n'a été trouvé dans le bibliographie

### 2) Ajout de métadonnées
Deux fichiers csv ont été crée afin de faciliter la lecture du tableau principal ("ComptageBiomasseFaune-PierreNoire-2010-2022"), leur noms indiquant explicitement le contenu :
- "MetadataTaxonomy-PierreNoire-2010-2022": Nom dans le tableau donné pour le stage M1, AlphaID et nom
    accepté (au 2 Décembre 2025) en important les noms scientifiques
    (Genre espèce) sur WoRMS
- "MetadataSampling-PierreNoire-2010-2022" : fichier contenant la méthode d'échantillonage, la latitude, 
   la longitude, le PID associé, la profondeur, la date d'échantillonage, la surface échantilloné, l'unité 
   et enfin l'opérateur (non renseignée ici car infirmation indisponible)
    
### 3) Organisation de l'espace de travail
Suite à nos modifications, nous proposons une nouvelle organisation de l'espace de travail :
```
├── Projet macrobenthos
│ └── Inputs
│     └── Données initales
│         └── A COMPLETER avec meilleurs noms
│     └── Metadonnées
│         └── MetadataTaxonomy-PierreNoire-2010-2022
│         └── MetadataSampling-PierreNoire-2010-2022
│ └── Scripts
│     └── PCoa_BiomassWithoutRareSpecies.R
│     └── Correlation_TemperatureProduction.R
│     └── KruskalWallis_Boxplot_Productivity.R
│ └── Output  
│     └── Données intermédiaires 
│         └── CorrelationData_TProd.csv
│         └── PBDataFor_KruskallWallis_BoxPlot.csv
│         └── PCoA_Bio_WithoutRareSpecies.csv
│     └── Résultats statistiques
│         └── COMPLETER GRAPHES PCA
```    
/!\ données intermédiaires obtenues manuellement mais pour une vraie fairisation aurait dûes être obtenues via R


### 4) Explication de l'analyse = "Vrai ReadMe"
Commencer par fichier biomasse 
Macroexcel a calculé productivité
_Se rapporter au rapport de stage pour le materiel et méthodes plus étoffé_
#### Calcul de la production
Production = Productivité*Biomasse moyenne 

##### Calcul de la biomasse
D'après le fichier "pn-2010-2022_compil-abundance_biomasses_harm_iso"" : 
Biomasse moyenne = moyenne des biomasses moyennes en octobre et mars 
Moyenne pour octobre ou mars = biomasse individuelle moyenne * abondance

##### Calcul de la productivité
petite liste des fichiers en "chunck"
D'après Macroexcel de Brey et la matrice fonctionnelle et SOMLIT : 
Productivité = brey 
brey = temperature 
temperature moyenne = moyenne(temperature / mois somlit)

### 5) Données intermédiaires
Calculs productions au seind es excel mais aurait du etre fait sur R, donc ne seront pas traités 
Pour réaliser les statistiques, des fichiers excel intermédiaires ont été faits mais ne sont pas fairisable (devrait faire scripts mais manque de temps) mais on s'est servi de fichiers excel, cela peut constituer un biais.

### 6) Analyses / scripts
Pas d'ordre spécifique aux scripts car chacun correspond à une analyse différente
-  "" SOMLIT = regression temperature production (à ne pas mettre pour linstant car on se préoccupe seulement de lobjectif calculer la production pour linstant ?)
Permet de rep à la question est ce quil y a correlation
-   Liens et exemples de début scripts PCoA 
-   Liens qui va aux scripts Cor1, 2, 3 et Kruskall
Exemple du meme exemple plus haut 
+ leur description et dire ce qu'on a fait (commenter+, read, bannière, structure, version de R (à ajouter dans la bannière ?), versions des packages à mettre)
Mais manque le fait que tout doit être écrit en anglais


### **à retirer ?** Axes d'améliorations qui n'ont pas pu être mis en place (à intégrer direct au fil du readme)
Certains formatages et calculs comme ceux de la production, la productivité, etc. ont été effectués manuellement sur Excel lors du stage, 
qui auraient mérités d'être réalisés avec R pour augmenter la reproductibilité, 
cependant nous n'avons pas pu les modifier dans le temps imparti.

-   Montrer les premières lignes des scripts améliorés avec leurs noms
    en haut comme ex du diapo
