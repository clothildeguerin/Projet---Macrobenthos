# Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix
## Etat initial
### Description du projet
Les pressions anthropiques croissantes perturbent le fonctionnement des écosystèmes côtiers. Suite à la marée noire de l’Amoco Cadiz en 1978, la station Pierre
Noire (baie de Morlaix) fait l’objet d’un suivi à long terme de sa communauté macrobenthique. La production secondaire, mesurée ou modélisée, est un bon
indicateur de l’état écologique d’une communauté. Toutefois, cette mesure n’a jamais été appliquée en routine sur ce site. Dans le cadre de cette étude, la
production secondaire a été estimée en utilisant le modèle de Brey. Ce modèle, basé sur un calcul par réseau de neurones, permet d’estimer la production
secondaire à partir de diverses variables écologiques.

Quelle est la relation entre l’évolution de la production secondaire et les changements de structure de la communauté de Pierre Noire ?

Pour répondre à cette question, nous avons comme données initiales : 
- Abondances spécifiques mars et octobre tous les ans entre 2010 et 2022 
- Matrice de traits fonctionnels (incomplète)
- Macroexcel Brey
(mettre noms donnés aux tableaux (qu'on va mettre dans l'arborescence) mais qu'on ne met pas sur github)

### Structure / noms initiaux
- Mettre exemples / noms des colonnes (demander à clothilde la structure et noms initiaux)
├── StageM1
│   └── Scripts
│        ├── Cor TProd.R
│        ├── Cor BioProdSomme.R
│        ├── CorrSpearman.R
│        ├── KurskallWallis_boxplot.R
│        ├── PCoA Bio withoutrare.R
│        └── PCoA Bio moy - Copie.R
│   └── Données
        ├── ...

### Scripts / analyses initiaux
- Liens qui va aux scripts ? et 
### Output initiaux (peut etre pas besoins ?)

## Fairisation (de l'objectif _ _ _)
### Traçage des données initiales 
- PID de la zone
- PID de la station PN
- PID SOMLIT
- PID des auteurs (Sarah Bureau)
- PAS FAIRISABLE : Il manque les sources de la matrice de traits fonctionnels, a été donnée telle quelle, a été complétée sans non plus ajouter les sources au fur et à mesure, n'a pas indiqué les endroits qui ont été estimés si rien n'a été trouvé dans le bibliographie

### Ajout de métadonnées
- Taxons : Nom dans le tableau donné pour le stage M1, AlphaID et nom accepté (au 2 Décembre 2025) en important les noms scientifiques (Genre espèce) sur WoRMS
- 
### Structure / noms de fichiers
- Arborescence avec "faux fichiers textes"
├── data
│   └── test.csv
└── Scripts
    ├── Cor TProd.R
    ├── Cor BioProdSomme.R
    ├── CorrSpearman.R
    ├── KurskallWallis_boxplot.R
    ├── PCoA Bio withoutrare.R
    └── PCoA Bio moy - Copie.R
### Scripts / analyse améliorés
- Montrer les premières lignes des scripts améliorés




