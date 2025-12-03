**/!\ NE PAS FAIRE "VISUAL" car change la structure**
# README de l'étude "Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"

## Etat initial
Dans cette partie nous décrivons l'état initial des données non fairisé juste après le
stage de Master 1 de Chlothilde Guerin (Année universitaire 2024-2025).
Ce README ne faisait pas partie des documents initiaux. 

### Description du projet 
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

### fichiers de départ
Pour répondre aux objectifs, les fichiers Excels fournis au départ du stage sont les suivants : 
- "pn-2010-2022_compil-abundance_biomasses_harm_iso" : Abondances et biomasses individuelles mars et octobre tous les ans
entre 2010 et 2022 
- "FC-PN-77-07_AD" : Matrice de traits fonctionnels (incomplète) 
- "ProductivityANN01" : Macroexcel Brey (à mettre sur github car standard) 

_Se rapporter au rapport de stage pour le materiel et méthodes, contexte plus éttofé_

Mettre exemples / noms des colonnes (demander à clothilde la structure
et noms initiaux) 


### Organisation de l'espace de travail
``` 
├── M1 Sciences de la Mer 
│ └── Stage Roscoff 
│     └── Articles stage 
│          └── Articles de référence
│          └── différentes versions du rapport de stage et des présentations
│     └── Data stage
│          └── Résultats et graphique 
│                   └── fichiers pdf des résultats
│                   └── images des graphiques
│          └── Tableau Brey (Taxo + abiotique)
│                   └── “FC-PN-77-07-AD"
│                   └── “Tableau data input Brey (ANN)”
│                   └── “ taxonomy-PN-77-07”
│                   └── “Coding"
│          └── Fichiers et scripts PCoA ACP R
│                   └── PCoA_Bio_wthrare
│                   └── Cor_TProd
│                   └── Cor_BioProdg_Somme
│                   └── autres cripts d'exploration des données
│          └── Comparaison modèles empiriques
│                   └── Images de formules issues des articles
│                   └── Tableau excel avec calculs pour comparer les méthodes
```

### Scripts initiaux
Les Dataset initiaux utilisés sur le logiciel Rstudio n'étaient pas nommés de manière claire et compréhensible par tous,
il n'y avait également pas de commentaires. Voici un exemple de script non FAIRisé (extrait du script "") : 





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




## FAIRisation 
Dans cette deuxième partie nous indiquons les axes d'améliorations afin de FAIRiser la structure, les métadonnées et les analyses.
Ce présent document est une première étape dans notre démarche de rendre FAIR ce travail. 
Le dernier objectif du stage nous a paru difficile à fairiser. 

### Organisation de l'espace de travail
Suite à nos modifications, nous proposons une nouvelle organisation de l'espace de travail :
```
├── Projet macrobenthos
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
