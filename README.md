# FAIRisation d'un projet de stage de Master 1 _"Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"_ 

Ce stage a été réalisé par Clothilde Guerin (Année universitaire 2024-2025) et encadré par Eric THIEBAUT et Pascal RIERA, enseignants-chercheurs à la Station Biologique de Roscoff. Ce document à été rédigé par Laure DOGNON, Clothilde GUERIN et Lola MONTJARRET, étudiantes en Master Sciences de la Mer à Sorbonne Université (2025). 

## Introduction 
### 1) Description du projet 

Les pressions anthropiques croissantes perturbent la structure et le fonctionnement des
écosystèmes côtiers. Suite à la marée noire de l’Amoco Cadiz en 1978, la station Pierre Noire (en baie de Morlaix) fait l’objet d’un suivi à long terme de sa communauté macrobenthique. La production secondaire est un bon indicateur de l’état écologique d’une communauté. Toutefois, cette mesure n’a jamais été appliquée en routine sur ce site. Dans le cadre de cette étude, la production secondaire a été estimée en utilisant le modèle de Brey. Ce modèle empirique permet d’estimer la production secondaire à partir de diverses variables écologiques et environnementales.

Problématique de l'étude : quelle est la relation entre l’évolution de la production secondaire et
les changements de structure de la communauté de Pierre Noire ?

Pour répondre à cette question, quatre objectifs ont été définis : 
- 1 : Compléter les suivis de la communauté macrobenthique de Pierre Noire via l'estimation de la production secondaire
- 2 : Mettre en évidence la relation entre les variations interannuelles de production secondaire et les changements de structure de cette communauté 
- 3 : Comparer les niveaux de productivité entre différents groupes trophiques 
- 4 : Comparer les ratios P/B (productivité) calculés par différents modèles empiriques à des valeurs in situ issues de la littérature

Les nombreux fichiers, scripts, et analyses produites durant ce projet pourraient être réutilisés pour de futurs suivis ou comparaisons, que ce soit par la stagiaire, l'encadrant ou d'autres chercheurs. Pour garantir cette réutilisation et permettre la reproductibilité de cette étude, il est essentiel de rendre l’ensemble des données et des traitements transparents et accessibles. C’est précisément ce que vise la démarche FAIR.

### 2) Rappel de la démarche FAIR 
La démarche FAIR, inscrite dans les principes de la Science Ouverte, correspond à un acronyme décrivant quatre principes essentiels pour garantir la reproductibilité des analyses scientifiques : 
#### F pour Findable : Les données doivent être faciles à retrouver 
#### A pour Accessible : Les données doivent pouvoir être consultées et téléchargées
#### I pour Interoperable : Les données doivent être exploitables quel que soit l’environnement informatique utilisé 
#### R pour Reusable : Les données doivent être réutilisables 

### 3) Objectif de ce document
L'objectif de ce dépôt est I) d’analyser l’état initial des données, scripts et analyses produits durant le stage, et II) de proposer une première approche de FAIRisation pour une partie de ces éléments. 

## I- Etat initial
Dans cette partie nous décrivons l'état initial des données non FAIRisées, juste après le stage. 

### 1) Données d'entrée
Pour répondre aux objectifs, les fichiers au format Excel (.xlsx) fournis initialement sont les suivants : 
- pn-2010-2022_compil-abundance_biomasses_harm_iso.xlsx : Abondances et biomasses individuelles pour plus de 200 espèces (échantillonnages en mars et octobre, période 2010-2022). En voici un extrait :

| taxon_compil(harm_isotopes) | Analyse en isotopie | mars-10 | Oct-10 | mars-11 | Oct-11 |
|-----------------------------|---------------------|---------|--------|---------|--------|
| Abra alba                   |                     | 11      | 30     | 22      | 62     |
| Abra prismatica             |                     | 3       | 15     | 2       | 17     |

- FC-PN-77-07_AD.xlsx : Matrice de traits fonctionnels alimentée par différents collaborateurs et partiellement complétée durant le stage. Aucun historique des modifications, des contributeurs ni des sources utilisées → traçabilité insuffisante, rendant une FAIRisation complète impossible
- ProductivityANN01.xlsx : Macro Excel développée par Thomas Brey pour estimer la productivité des espèces (disponible en libre accès sur thomas-brey.de) 
- SOMLIT_RoscoffEstacade_Hydro_v2023.xlsx : Données de température SOMLIT pour la station Estacade (2010-2023), transmises directement par l’encadrant. Aucun DOI n’y était associé mais elles sont bien trouvables sur SEANOE (seanoe.org, DOI 10.17882/100323) ou sur demande via somlit.fr.

Des fichiers de métadonnées accompagnaient également ces données d’entrées : 
Coding.xlsx : règles de codage des traits fonctionnels
Taxonomy-PN-77-07.xlsx : informations taxonomiques de plus de 350 espèces, sans PID
Mais absence de métadonnées pour les données de biomasses et abondances.



### 2) Organisation de l'espace de travail
``` 
├── M1 Sciences de la Mer 
│   └── Stage Roscoff 
│       └── Data stage
│           └── Résultats et graphiques
│               └── Images des graphiques
│           └── Tableau Brey (Taxo + abiotique)
│               └── FC-PN-77-07-AD.xlsx
│               └── Tableau data input Brey (ANN).xlsx
│               └── Taxonomy-PN-77-07.xlsx
│               └── Coding.xlsx
│               └── SOMLIT_RoscoffEstacade_Hydro_v2023.xlsx
│           └── Fichiers et scripts PCoA ACP R
│               └── PCoA Bio wthrare.R
│               └── KruskallWalis_Boxplot.R
```
Bien qu'on observe une première logique d'organisation, la structure initiale reste difficile à appréhender :  les fichiers étaient nombreux et dispersés dans plusieurs sous-dossiers. A noter que l'arborescence présentée ici ne reprend que les fichiers utilisés pour répondre aux 3 premiers objectifs du stage. De nombreux autres fichiers étaient présents - liés à l’objectif 4, à des explorations de données ou tests intermédiaires.

### 3) Description des analyses
Bien qu’une section “matériel et méthodes” soit présentée dans le rapport, elle ne décrit pas précisément le passage des données initiales vers les analyses, rendant le processus non reproductible. De plus, aucun ReadMe n’était présent. 

### 4) Scripts initiaux
Voici un exemple d'un script (["PCoA Bio withoutrare.R"](<./Scripts/Scripts_initiaux/PCoA Bio withoutrare.R>)) non FAIRisé : 

```
LOLA AJOUTE NUMEROS LIGNES STP
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
Les scripts contiennent des commentaires peu compréhensibles ainsi que des lignes de codes superflues. Également, le chargement des données n’était pas intégré car réalisé manuellement à chaque lancement des scripts. Ils ne comportent pas non plus de description initiale (objectif, auteur, date, version). Ce constat illustre la nécessité de les FAIRiser afin d’assurer leur reproductibilité. 

## II- FAIRisation 
Dans cette deuxième partie nous indiquons des axes d'améliorations pour  FAIRiser la structure, les métadonnées et les analyses réalisées au cours du stage. Ce document est une première étape dans notre démarche pour améliorer ce travail. Une FAIRisation plus complète aurait nécessité de rédiger le ReadMe et les scripts en anglais, pour en faciliter la diffusion et la réutilisation. Par manque de temps cette étape n’a pas pu être réalisée, elle est donc simplement notifiée comme amélioration future. 

### 1) Ajout de métadonnées
Deux fichiers de métadonnées au format .csv ont été créés pour accompagner le tableau de donnée initial ComptageBiomasseFaune-PierreNoire-2010-2022".csv et pour faciliter leur réutilisation :
 - ["MetadataTaxonomy-PierreNoire-2010-2022.csv"](./Metadonnées/MetadataTaxonomy-PierreNoire-2010-2022.csv) : contient plusieurs champs taxonomiques, le nom des espèces renseigné dans le tableau initial ainsi que les noms scientifiques acceptées (mis à jour via la plateforme World Register of Marine Species https://www.marinespecies.org) et l’AphiaID associé. 
→ Objectif : se rapprocher d’une standardisation conforme à Darwin Core

Remarque : Les correspondances taxonomiques ont été obtenues via la fonction Match Taxa de WoRMS. Lorsque les noms comportaient “sp.” ou “spp.”, ceux-ci ont été retirés pour permettre l’identification du genre. Certaines correspondances étaient ambiguës ; ces cas sont indiqués dans les colonnes Match_Type et Ambiguity du fichier de métadonnées (par ex. ambiguïtés liées à des homonymes (Homonym) ou à des erreurs historiques de classification (HistoricalConfusion)._

Ajouter exemple métadata

["MetadataSampling-PierreNoire-2010-2022.csv"](./Metadonnées/MetadataSampling-PierreNoire-2010-2022.csv) : contient : méthode d’échantillonnage, surface échantillonnée, unité, coordonnées (latitude/longitue), PID associé au site, profondeur, opérateur (non renseigné car information manquante)
→ Objectif : se rapprocher du standard BENTHOBS car adapté à la nature de nos données. Une FAIRisation complète selon ce standard n’est pas possible car certaines informations et données requises n’étaient pas disponibles. 
    
### 2) Organisation de l'espace de travail
Suite à nos modifications, nous proposons une nouvelle organisation de l'espace de travail, associée à une correction des noms des fichiers pour les rendre plus compréhensibles :
```
├──Projet—Macrobenthos
│ └── Inputs
│     └── InitialData
│         └── FunctionalTraitsMatrix.csv
│         └── BiomassAbundance_PierreNoire_2010-2022.csv
│         └── SOMLIT_RoscoffEstacade_2010-2023.csv
│     └── Tools
│         └── BreyProductivity_MacroExcel.xlsx
│     └── Metadata
│              └── Metadata_BiomassAbundance
│                      └── MetadataTaxonomy_PierreNoire_2010-2022.csv
│                      └── MetadataSampling_PierreNoire_2010-2022.csv
│              └── Metadata_FunctionalTraitsMatrix
│                      └── Metadata_CodingFunctionalTraits.csv
│ └── Scripts
│     └── BiomassWithoutRareSpecies_PCoA.R
│     └── FunctionalGroupProductivity_KruskalWallis.R
│ └── Output  
│         └── IntermediateData
│                 └── DataFunctionalGroupProductivity_KruskalWallis.csv
│                 └── DataBiomassWithoutRareSpecies_PCoA.csv
│         └── Results
│                 └── ResultsBiomassWithoutRareSpecies_PCoA.jpeg
│                 └── ResultsKruskalWallis.jpeg
```    

### 3) Description des analyses 
Tout d’abord, la majorité des étapes de préparation des données (calculs intermédiaires, nettoyage et réorganisation, pré-formatage, etc.) ont été réalisées directement dans Excel sous forme de tableaux intermédiaires. Ces opérations, non scriptées dans R, présentent une traçabilité et une reproductibilité très limitées, voire inexistantes. Par manque de temps, seuls les fichiers intermédiaires indispensables à la réalisation des analyses statistiques liées aux trois premiers objectifs du stage ont pu être FAIRisés. Cette section décrit donc, aussi clairement que possible, le cheminement des données et des scripts utilisés pour ces trois objectifs. Le quatrième objectif du stage n’est pas documenté, faute de temps.

#### Objectif 1 : Compléter les suivis de la communauté macrobenthique de Pierre Noire via l'estimation de la production secondaire

##### Etape 1 : Calcul de la biomasse moyenne annuelle
A partir du fichier initial  Macrofauna-PierreNoire-2010-2022.csv, la biomasse moyenne annuelle de chaque espèce a été calculée comme la moyenne des biomasses mesurées en octobre et en mars pour chaque année.

##### Etape 2 : Calcul de la productivité
La productivité annuelle de chaque espèce a été estimée à l'aide de la macro Excel développée par Brey, qui calcule automatiquement la productivité à partir d’un ensemble de variables écologiques et environnementales renseignées manuellement. Les données que l'on renseigne dans ce fichier sont : 
- La température moyenne annuelle : calculée pour chaque année à partir des données SOMLIT_RoscoffEstacade_2010-2023.csv (Station Estacade, 2010-2023) 
- Les modalités de plusieurs traits fonctionnels : renseignés à partir de la matrice de trait fonctionnels FunctionalTraitsMatrix.csv 

Remarque : _Comme cette macro demande un fichier d’entrée avec un format et une structure précise, un tableau intermédiaire a été construit durant le stage. Celui-ci renseigne, pour chaque espèce, l’ensemble des variables attendues par la macro, ce qui nous permet de remplir automatiquement le fichier excel sans avoir à saisir manuellement chaque ligne. _

#### Etape 3 : Calcul de la production secondaire
La production secondaire annuelle pour chaque espèce a été calculée dans un fichier intermédiaire selon la formule :
- Production = Biomasse moyenne annuelle (cf. Etape 1)*Productivité (cf. Etape 2)

#### Objectif 2 : Mettre en évidence la relation entre les variations interannuelles de production secondaire et les changements de structure de la communauté 

##### Etape 1 : Préparation des données 
Production d’un tableau contenant les biomasses moyennes annuelles des espèces, après exclusion des espèces rares  → fichier intermédiaire BiomassWithoutRareSpecies_PCoA.csv

##### Etape 2 : Analyse multivariée (PCoA)
Réalisation d’une PCoA à partir du fichier BiomassWithoutRareSpecies_PCoA.csv → script BiomassWithoutRareSpecies_PCoA.R

##### Etape 3 : Obtention des résultat de l’analyse → “..jpeg” 

#### Objectif 3 : Comparer les niveaux de productivité entre groupes trophiques 

##### Etape 1 : Attribution des groupes trophiques aux espèces
A partir des informations issues de la matrice de traits fonctionnels, attribution de chaque espèce à l’un des groupes trophiques prédéfini (prédateurs, déposivores de surface ou de sub-surface, suspensivores)

##### Etape 2 : Préparation des données
Création d’un tableau regroupant les valeurs de productivité (issues de la macro excel de Brey) pour chaque groupe trophique → fichier intermédiaire KruskallWallis_Boxplot_Productivity.csv 

##### Etape 3 : Analyse statistique 
Test de Kruskal - Wallis à partir du fichier KruskallWallis_Boxplot_Productivity.csv  → script FunctionalGroupProductivity_KruskallWallis.R

##### Etape 4 : Résultat de l’analyse → “ResultsKruskalWallis.jpeg” 

### 4) Fairisation des scripts

Le script initial ["PCoA Bio withoutrare.R"](./Scripts/Scripts_initiaux/PCoA Bio withoutrare.R) à été révisé et amélioré en ["PCoA_BiomassWithoutRareSpecies.R"](./Scripts/Scripts_finaux/PCoA_BiomassWithoutRareSpecies.R) comme suit : 
```
...
```
Ainsi, ont été ajoutés : une bannière structurée (nom complet, description, auteur, date et version), un chargement explicite des données ainsi que des commentaires plus détaillés et une organisation plus claire. En revanche, la traduction complète du script en anglais (diffusion internationale) n’a pas pu être faite par manque de temps.

## Conclusion
Ce travail de FAIRisation a permis d’améliorer l’organisation et la traçabilité d’une partie des données et analyses réalisées au cours de ce projet. Bien que certaines améliorations n’aient pas pu être finalisées, les corrections menées constituent une base solide pour assurer la réutilisation et la reproductibilité des analyses et résultats. Ce travail pourra ainsi servir de point de départ pour poursuivre les améliorations proposées, prolonger les analyses existantes ou bien pour étendre cette démarche FAIR à d’autres jeux de données. 
