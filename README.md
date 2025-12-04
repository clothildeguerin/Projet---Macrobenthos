**/!\ NE PAS FAIRE "VISUAL" car change la structure**
# Rendre FAIR certains points de l'étude "Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"

## 1) Contexte du projet et état initial
Dans cette première partie, nous décrivons l'état initial des données et analyses non fairisées produites durant le stage de Master 1 de Clothilde GUERIN (2024/2025).
Ce document README ne faisait pas partie des documents initiaux : il a été créé dans le cadre de ce travail de fairisation. 

### 1.1) Résumé du projet 
Les pressions anthropiques croissantes perturbent la structure et le fonctionnement des
écosystèmes côtiers.  Ces problématiques ammènent les scientifiques à mettre en place des suivis des communautés marine pour caractériser leur état de santé. A titre d'exemple, suite à la marée noire de l’Amoco Cadiz en 1978, la
station Pierre Noire (baie de Morlaix) fait l’objet d’un suivi à long
terme de sa communauté macrobenthique. La production secondair est un bon indicateur de l’état écologique d’une
communauté. Elle peut se faire à l'échelle des populations, à partir de l'analyse de la croissance et de la mortalité, ou bien à l'échelle des communautés via des modèles empiriques. Un des modèles les plus utulisé est celui de Brey (2012), qui n'avait jusque là jamais été utilisé pour Pierre Noire.Ce modèle, basé sur un calcul par un réseau de neurones, permet d’estimer la production secondaire
à partir de diverses variables écologiques et environnementales.

### 1.2) Objectifs du stage
Les différents objectifs de ce stage étaient de : 
- 1 : Compléter les suivis et analyses sur la structure + le fonctionnement de la communauté macrobenthique de Pierre Noire, via l'estimation de la production secondaire
- 2 : Relier les variations interannuelles de la production secondaire à celles de la structure de la communauté 
- 3 : Estimer la contribution des groupes taxonomiques et guildes trophiques à la production secondaire
- 4 : Objectif additionnel -->  Comparer les ratios P/B (productivité) calculés par différents modèles empiriques à des valeurs in situ, considérées comme mesures de référence

Problématique globale de l'étude : quelle est la relation entre l’évolution de la production secondaire et
les changements de structure de la communauté de Pierre Noire ?

### 1.3) Données de départ (non FAIRisées)
Pour répondre aux objectifs, les fichiers fournis initialement étaient les suivants, sous format Excel (.xls) : 
- "pn-2010-2022_compil-abundance_biomasses_harm_iso" : Abondances et biomasses (mars et octobre, de 2010 à 2022)
entre 2010 et 2022 
- "FC-PN-77-07_AD" : Matrice de traits fonctionnels + son codage en métadonnées (préciser codage des traits + tableau taxonomie ?)
- "ProductivityANN01" : Macro Excel développée par Brey pour le calcul de la productivité

Au cours du stage, plusieurs tableaux dits "intermédiaires" ont également été produits. Ils ont servi directement aux analyses réalisées sous R et ne présentent donc aucune description ou métadonnées.  

_Se rapporter au rapport de stage pour le materiel et méthodes, contexte plus éttofé_ ??

+ mettre image d'un tableau de donnée initial
Voici à titre d'exemple la structure initiale du fichier "pn-2010-2022_compil-abundance_biomasses_harm_iso".

### 1.4) Organisation initiale de l'espace de travail
``` 
├── M1 Sciences de la Mer 
│ └── Stage Roscoff 
│     └── Articles stage 
│          └── Articles fournis
│          └── Différentes versions du rapport de stage et │              des présentations
│     └── Data stage
│          └── Résultats et graphique 
│                   └── Fichiers pdf des résultats
│                   └── Images des graphiques
│          └── Tableaux Brey (Taxo + abiotique)
│                   └── “FC-PN-77-07-AD.xls"
│                   └── “Tableau data input Brey          │                       (ANN).xls”
│                   └── “taxonomy-PN-77-07.xls”
│                   └── “Coding.xls"
│          └── Fichiers et scripts PCoA ACP R
│                   └── "PCoA_Bio_wthrare.xls"
│                   └── "Cor_TProd.xls"
│                   └── "Cor_BioProdg_Somme.xls"
│                   └── autres scripts d'exploration des  │                       données
│          └── Comparaison modèles empiriques
│                   └── Images de formules issues des     │                       articles
│                   └── Tableaux de comparaison
```
Bien qu'on observe une première logique d'organisation, la structure reste complexe et difficile à appréhender. 


### Scripts R initiaux
Les scripts R initiaux présentent plusieurs points qui ne respectent pas le processus FAIR : noms des fichiers peu explicites, manque de commentaires pertinents, absence d'une structure.
Voici un exemple de script non FAIRisé (extrait du script ""), représentatif de l'ensemble des scripts :



## 2) FAIRisations d'une partie des données

Cette deuxième partie vise à décrire les améliorations mises en place pour rendre une partie des données et analyses plus "FAIR". En effet, étant donné du temps limité, cette FAIRisation reste partielle. Cependant, les différentes approches présentées peuvent être étendues au reste des données. 

### 2.1) Nouvelle organisation de l'espace de travail
Suite à nos modifications, nous proposons une nouvelle organisation de l'espace de travail. Une arborescence plus claire est définie : 
```
├── Projet Macrobenthos
│ └── Inputs
│     └── Données initales
│     └── Metadonnées
│          └── MetadataTaxonomy-PierreNoire-2010-2022
│          └── MetadataSampling-PierreNoire-2010-2022
│ └── Scripts
│      └── PCoa_BiomassWithoutRareSpecies.R
│      └── Correlation_TemperatureProduction.R
│      └── KruskalWallis_Boxplot_Productivity.R
│ └── Output  
      └──
│      └── Données intermédiaires 
│      └── Résultats statistiques
│            └── 
```    

#### Calcul de la production
Production = Productivité/Biomasse moyenne ##### Calcul de la biomasse
D'après le fichier "pn-2010-2022_compil-abundance_biomasses_harm_iso"" : 
Biomasse moyenne = moyenne des biomasses moyennes en octobre et mars 
Moyenne pour octobre ou mars = biomasse individuelle moyenne * abondance

##### Calcul de la productivité
petite liste des fichiers en "chunck"
D'après Macroexcel de Brey et la matrice fonctionnelle et SOMLIT : 

Productivité = brey 
brey = temperature 
temperature moyenne = moyenne(temperature / mois somlit)

#### Analyses univarié
- SOMLIT = regression temperature production (à ne pas mettre pour linstant car on se préoccupe seulement de lobjectif calculer la production pour linstant ?)

#### Analyses multivariées
-   Liens et exemples de début scripts PCoA 

#### Analyses statistiques
-   Liens qui va aux scripts Cor1, 2, 3 et Kruskall

Suite à cet état initial, nous nous somems rendu compte que l'ensemble des données traitées par le stage ne respectaient pas le principe FAIR. Nous proposons donc de rendre une partie de ce travail FAIR. 



## FAIRisation 
Dans cette deuxième partie nous indiquons les axes d'améliorations afin de FAIRiser la structure, les métadonnées et les analyses.
Ce présent document est une première étape dans notre démarche de rendre FAIR ce travail. 
Le dernier objectif du stage nous a paru difficile à fairiser. 



### Traçage des données initiales 
- PID de la zone
- PID de la station PN 
- PID SOMLIT - PID des auteurs (Sarah
Bureau) 
- PAS FAIRISABLE : Il manque les sources de la matrice de traits
fonctionnels, a été transmise telle quelle, a été complétée sans non plus
ajouter les sources au fur et à mesure, n'a pas indiqué les endroits qui
ont été estimés si rien n'a été trouvé dans le bibliographie

### Ajout de métadonnées
Deux fichiers csv ont été crée afin de faciliter la lecture du tableau principal ("ComptageBiomasseFaune-PierreNoire-2010-2022"), leur noms indiquant explicitement le contenu :
- "MetadataTaxonomy-PierreNoire-2010-2022": Nom dans le tableau donné pour le stage M1, AlphaID et nom
    accepté (au 2 Décembre 2025) en important les noms scientifiques
    (Genre espèce) sur WoRMS
- "MetadataSampling-PierreNoire-2010-2022" : fichier contenant la méthode d'échantillonage, la latitude, 
   la longitude, le PID associé, la profondeur, la date d'échantillonage, la surface échantilloné, l'unité 
   et enfin l'opérateur (non renseignée ici car infirmation indisponible)

    
## Axes d'améliorations qui n'ont pas pu être mis en place
Certains formatages et calculs comme ceux de la production, la productivité, etc. ont été effectués manuellement sur Excel lors du stage, 
qui auraient mérités d'être réalisés avec R pour augmenter la reproductibilité, 
cependant nous n'avons pas pu les modifier dans le temps imparti.

-   Montrer les premières lignes des scripts améliorés avec leurs noms
    en haut comme ex du diapo
