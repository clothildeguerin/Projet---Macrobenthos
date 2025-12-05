**/!\ NE PAS FAIRE "VISUAL" car change la structure**
# FAIRisation d'un projet de stage de Master 1 _"Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"_ Réalisé par Clothilde Guerin (Année universitaire 2024-2025).

Les encadrants de ce stage étaient Eric THIEBAUT et Pascal RIERA, enseignants-chercheurs à la Station Biologique de Roscoff. Ce présent document à été rédigé par Laure DOGNON, Clothilde GUERIN et Lola MONTJARRET, étudiantes en Master Sciences de la Mer à Sorbonne Université (2025). 

## Introduction 
### 1) Description du projet 
_Carte montrant l'emplacement du site d'étude : Pierre Noire_

Les pressions anthropiques croissantes perturbent la structure et le fonctionnement des
écosystèmes côtiers. Suite à la marée noire de l’Amoco Cadiz en 1978, la
station Pierre Noire (en baie de Morlaix) fait l’objet d’un suivi à long
terme de sa communauté macrobenthique. La production secondaire, mesurée
ou modélisée, est un bon indicateur de l’état écologique d’une
communauté. Toutefois, cette mesure n’a jamais été appliquée en routine
sur ce site. Dans le cadre de cette étude, la production secondaire a
été estimée en utilisant le modèle de Brey. Ce modèle empirique, basé sur un
calcul par réseau de neurones, permet d’estimer la production secondaire
à partir de diverses variables écologiques et environnementales.

Problématique de l'étude : quelle est la relation entre l’évolution de la production secondaire et
les changements de structure de la communauté de Pierre Noire ?

Pour répondre à cette question, quatre objectifs ont été définis : 
- 1 : Compléter les suivis de la communauté macrobenthique de Pierre Noire via l'estimation de la production secondaire
- 2 : Mettre en évidence la relation entre les variations interannuelles de production secondaire et les changements de structure de cette communauté 
- 3 : Déterminer la contribution des différents groupes taxonomiques et trophiques à la production secondaire
- 4 : Comparer les ratios P/B (productivité) calculés par différents modèles empiriques à des valeurs in situ issues de la littérature

Les nombreux fichiers, scripts, et analyses produites durant ce projet pourraient être réutilisés pour de futurs suivis ou comparaisons, que ce soit par la stagiaire, l'encadrant ou d'autres chercheurs. Pour garantir cette réutilisation et permettre la reproductibilité de cette étude, il est essentiel de rendre l’ensemble des données et des traitements transparents et accessibles. C’est précisément ce que vise la démarche FAIR.

### 2) Rappel de la démarche FAIR 
La démarche FAIR, inscrite dans les principes de la Science Ouverte, correspond à un acronyme décrivant quatre principes essentiels pour garantir la reproductibilité des analyses scientifiques : 
#### a) F pour Findable : Les données doivent être faciles à retrouver grâce à des identifiant pérenne (PID), des métadonnées précises, l’ensemble étant déposé sur un entrepôt.
#### b) A pour Accessible : permet l’accès et le téléchargement des données (protocole de communication standardisé). Les données doivent pouvoir être consultées et téléchargées
#### c) I pour Interoperable : Les données doivent être exploitables quel que soit l’environnement informatique utilisé (vocabulaire contrôlé, documentation avec un PID)
#### d) R pour Reusable : Les données doivent être réutilisables (attributs pertinents, licence de réutilisation)

### 3) 
L'objectif de ce dépôt est I) d’analyser l’état initial des données, scripts et analyses produits durant le stage, et II) de proposer une première approche de FAIRisation pour une partie de ces éléments. 

## I- Etat initial
Dans cette partie nous décrivons l'état initial des données non FAIRisées, juste après le
stage. 

### 1) Données d'entrée
Pour répondre aux objectifs, les fichiers au format Excel (.xlsx) fournis au départ du stage sont les suivants : 
- pn-2010-2022_compil-abundance_biomasses_harm_iso.xlsx : Abondances et biomasses individuelles mars et octobre tous les ans entre 2010 et 2022, pour plus de 200 espèces
- FC-PN-77-07_AD.xlsx : Matrice de traits fonctionnels complétée par diff thésards, collaborateurs…(incomplète → que j’ai dû compléter à certains endroits)
- ProductivityANN01.xlsx : Macro Excel développée par Brey permettant de calculer la productivité des espèces, disponible en libre accès sur thomas-brey.de 
- SOMLIT_RoscoffEstacade_Hydro_v2023.xlsx : Données de température SOMLIT pour la station Estacade (2010-2023), disponible en libre accès sur SEANOE 

Les données de température SOMLIT (station Estacade) sur 2010-2023, disponible en accès libre à  séries temporelles de température pour la station Estacade (2010-2023), accessibles en libre accès sur SEANOE (seanoe.org, DOI 10.17882/100323) ou par demande sur somlit.fr

Exemple : 
```

```
**Les Dataset initiaux utilisés sur le logiciel Rstudio n'étaient pas nommés de manière claire et compréhensible par tous.**
Tableau biomasse exemple (sous forme de chunck où on colle avec TABulations)
--> Pas de métadonnées 

### 2) Organisation de l'espace de travail
``` 
├── M1 Sciences de la Mer 
│   └── Stage Roscoff 
│       └── Articles stage 
│           └── Articles fournis
│           └── Différentes versions du rapport de stage et des présentations
│       └── Data stage
│           └── Résultats et graphique 
│               └── Fichiers pdf des résultats
│               └── Images des graphiques
│           └── Tableau Brey (Taxo + abiotique)
│               └── FC-PN-77-07-AD.xlsx
│               └── Tableau data input Brey (ANN).xlsx
│               └── Taxonomy-PN-77-07.xlsx
│               └── Coding.xlsx
│           └── Fichiers et scripts PCoA ACP R
│               └── PCoA_Bio_wthrare
│               └── Cor_TProd
│               └── Cor_BioProdg_Somme
│               └── Scripts tests
│           └── Comparaison modèles empiriques
│               └── Images de formules issues des articles
│               └── Tableaux de comparaison
```
Bien qu'on observe une première logique d'organisation, la structure reste complexe et difficile à appréhender ; les fichiers sont nombreux et ils sont dispersés dans plusieurs sous-dossiers, ce qui rend la navigation complexe. De plus, la langue utilisée n’est pas universelle.

### 3) Analyses
Initialement, aucun README n’est présent. Il y a bien une partie “matériel et méthodes” dans le rapport, mais cette dernière ne précise pas  mais pas de readme donc les détails du passage des données initials aux produits initiaux n'était pas présent donc difficile à reproduire
Ce README ne faisait pas partie des documents initiaux donc il n'y a pas d'explications des analyses, cela sera fait dans la partie 2.3.machin. 

#### a) Données intermédiaires

#### b) Scripts initiaux

Voici un exemple d'un script (["PCoA Bio withoutrare.R"](<./Scripts/Scripts_initiaux/PCoA Bio withoutrare.R>)) non FAIRisé : 

```
1 library(vegan)
... 
9 library("writexl")

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
#### Description des analyses
Manque

## III- FAIRisation 
Dans cette deuxième partie nous indiquons les axes d'améliorations afin de FAIRiser la structure, les métadonnées et les analyses des données du stage.
Tout d’abord, ce présent document est une première étape dans notre démarche pour améliorer ce travail. Le dernier objectif du stage (comparaison des modèles empiriques) nous a paru difficile à FAIRiser. Un axe de FAIRisation intéressant aurait été de rédiger ce README en anglais, tout comme les commentaires des scripts sur R, cependant cette tâche (traduction) nous aurait pris trop de temps c’est pourquoi elle est seulement notifiée ici.  

### 1) Traçage des données initiales 
- PID de la zone
- PID de la station PN 
- PID SOMLIT - PID des auteurs (Sarah
Bureau) 
- PAS FAIRisable : Il manque les sources de la matrice de traits
fonctionnels, a été transmise telle quelle, elle a été complétée sans non plus
ajouter les sources au fur et à mesure, n'a pas indiqué les endroits qui
ont été estimés si rien n'a été trouvé dans la bibliographie

### 2) Ajout de métadonnées
Deux fichiers csv ont été créé afin de faciliter la lecture du tableau principal ("ComptageBiomasseFaune-PierreNoire-2010-2022"), leur noms indiquant explicitement le contenu :
- ["MetadataTaxonomy-PierreNoire-2010-2022.csv"](./Metadonnées/MetadataTaxonomy-PierreNoire-2010-2022.csv) : Nom dans le tableau donné pour le stage M1, AlphaID et nom
    accepté (au 2 Décembre 2025) en important les noms scientifiques
    (Genre espèce ou genre sans sp. ou spp. derrière si l'espèce n'était pas spécifiée) sur WoRMS
Ajouter exemple métadata ou pas vu qu'on met le lien ?
- ["MetadataSampling-PierreNoire-2010-2022.csv"](./Metadonnées/MetadataSampling-PierreNoire-2010-2022.csv) : fichier contenant la méthode d'échantillonage, la latitude, 
   la longitude, le PID associé, la profondeur, la date d'échantillonnage, la surface échantillonnée, l'unité 
   et enfin l'opérateur (non renseignée ici car information indisponible)
   
    
### 3) Organisation de l'espace de travail
Suite à nos modifications, nous proposons une nouvelle organisation de l'espace de travail :
```
├──MacrobenthosProductionProject_PierreNoire_2010-2022
│ └── Inputs
│     └── Datasets
│         └── BreyProductivityAutomaticCalculation_MacroExcel.xlsx
│         └── FunctionalTraitsMatrix.csv
│         └── BiomassAbundance_PierreNoire_2010-2022.csv
│     └── Metadata
│              └── Metadata_BiomassesAbundances
│                      └── MetadataTaxonomy_PierreNoire_2010-2022.csv
│                      └── MetadataSampling_PierreNoire_2010-2022.csv
│              └── Metadata_FunctionalTraitsMatrix
│                      └── Metadata_CodingFunctionalTraits
│ └── Scripts
│     └──BiomassWithoutRareSpecies_PCoA.R
│     └──TemperatureProduction_Correlation.R
│     └──FunctionalGroup-Productivity_KruskallWallis.R
│ └── Output  
│         └── IntermediateData
│                 └── DataTemperature-Production_Correlation.csv
│                 └── DataFunctionalGroup-Productivity_KruskallWallis.csv
│                 └── DataBiomassWithoutRareSpecies_PCoA.csv
│         └── StatisticResults
│                 └── ResultsBiomassWithoutRareSpecies_PCoA.jpeg
│                 └── ResultsKruskalWallis.jpeg
│                 └── ResultsTemperature-Production_Correlation.jpeg
```    
/!\ données intermédiaires obtenues manuellement mais pour une vraie fairisation elles auraient dûes être obtenues via R
/!\ Sur github scripts initiaux VS finaux car problème avec un des script et à dû effacer 

### 4) Explication de l'analyse = "Vrai ReadMe"
Commencer par fichier biomasse 
Macroexcel a calculé productivité
_Se rapporter au rapport de stage pour le matériel et méthodes plus étoffé
#### Calcul de la production
Production = Productivité*Biomasse moyenne 

##### Calcul de la biomasse
D'après le fichier pn-2010-2022_compil-abundance_biomasses_harm_iso.xlsx : 
Biomasse moyenne = moyenne des biomasses moyennes en octobre et mars 
Moyenne pour octobre ou mars = biomasse individuelle moyenne * abondance

##### Calcul de la productivité
petite liste des fichiers en "chunck"
D'après Macroexcel de Brey et la matrice fonctionnelle et SOMLIT : 
Productivité = brey 
brey = temperature 
temperature moyenne = moyenne(temperature / mois somlit)

### 5) Données intermédiaires
Calculs productions au seind es excel mais aurait du être fait sur R, donc ne seront pas traités 
Pour réaliser les statistiques, des fichiers excel intermédiaires ont été faits mais ne sont pas FAIRisable (devrait faire scripts mais manque de temps) mais on s'est servi de fichiers excel, cela peut constituer un biais.

### 6) Analyses / scripts

Trois des principaux scripts produits lors de ce stage ont été revus afin d’améliorer leur traçabilité et leur réutilisabilité. Chaque script correspond à une analyse indépendante et ne suit donc pas un ordre particulier. Pour chacune des analyses; les données utilisées et les objectifs sont décrits ci-dessous :  

Objectif 1 : Identifier les espèces contribuant le plus aux variations interannuelles de production à partir d’une PCoA

Données utilisées : 
PCoA_Bio_WithoutRareSpecies.csv → tableau intermédiaire réalisé à partir du fichier initial Macrofauna-PierreNoire-2010-2022.csv, après calcul des biomasses moyennes annuelles et filtrage des espèces rares
MetadataTaxonomy-PierreNoire-2010-2022.csv → métadonnées taxonomiques associées aux espèces présentes dans le jeu de données initial

Objectif 2 : Comparer les valeurs de productivité entre  différents groupes trophiques

Données utilisées : 
KruskallWallis_Boxplot_Productivity.csv → tableau intermédiaire contenant les valeurs de productivité calculées à l’aide de la macro Excel de Brey
Tableau des groupes trophiques → tableau intermédiaire dérivé de la matrice de traits fonctionnels et de son codage, permettant d’attribuer chaque espèces à un groupe trophique

Objectif 3 : Tester l’existence d’une relation entre la température annuelle et la production secondaire

Données utilisées : 
Correlation_TemperatureProduction.csv → tableau intermédiaire regroupant les valeurs de production annuelle estimées à partir du modèle de Brey
Données SOMLIT → séries temporelles de température pour la station Estacade (2010-2023), accessibles en libre accès sur SEANOE (seanoe.org, DOI 10.17882/100323) ou par demande sur somlit.fr 

Le script initial ["PCoA Bio withoutrare.R"](./Scripts/Scripts_initiaux/PCoA Bio withoutrare.R) à été révisé et amélioré en ["PCoA_BiomassWithoutRareSpecies.R"](./Scripts/Scripts_finaux/PCoA_BiomassWithoutRareSpecies.R) comme suit : 
```
########################################################
# Description : Analyse PCOA - Données annuelles de biomasse (sans espèces rares)
# Nom : PCoA_BiomassWithoutRareSpecies.R
# Auteur : Clothilde GUERIN (PID = ...)
# Date : 3 Décembre 2025
########################################################

##### Chargement des données ####
PCoA_Bio_WithoutRareSpecies <- read.csv("data/PCoA_Bio_WithoutRareSpecies.csv")

##### Chargement de la librairie ####
library(vegan) #PCoA et distance de Bray-Curtis
...
library(ggrepel) #empêche les étiquettes de se chevaucher

#### Mise en forme du jeu de donnée ####

# La colonne "année" doit être officialisée car elle n'est pas correctement définie dans le dataset d'origine
head(PCoA_Bio_WithoutRareSpecies)
rownames(PCoA_Bio_WithoutRareSpecies)
...
```
Ainsi, ont été ajoutés : une bannière structurée (nom complet, description, auteur, date et version), un chargement explicite des données ainsi que des commentaires plus détaillés et une organisation plus claire. En revanche, certains éléments n’ont pas pu être intégrés par contrainte de temps, notamment la traduction complète du script en anglais (diffusion internationale) et la mention des versions des packages utilisés. 

## Conclusion
### **à retirer ?** Axes d'améliorations qui n'ont pas pu être mis en place (à intégrer direct au fil du readme)
Certains formatages et calculs comme ceux de la production, la productivité, etc. ont été effectués manuellement sur Excel lors du stage, 
qui auraient mérités d'être réalisés avec R pour augmenter la reproductibilité, 
cependant nous n'avons pas pu les modifier dans le temps imparti.

-   Montrer les premières lignes des scripts améliorés avec leurs noms
    en haut comme ex du diapo

Ce travail de FAIRisation a permis d’améliorer l’organisation et la traçabilité d’une partie des données et analyses réalisées au cours de ce projet. Bien que certaines améliorations n’aient pas pu être finalisées, les corrections menées constituent une base solide pour assurer la réutilisationet la reproductibilité des analyses et résultats. Ce travail pourra ainsi servir de point de départ pour poursuivre les améliorations proposées, prolonger les analyses existantes ou bien pour étendre cette démarche FAIR à d’autres jeux de données. 
