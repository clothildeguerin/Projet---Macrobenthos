**/!\ NE PAS FAIRE "VISUAL" car change la structure**
# Rendre FAIR "Evolution de la production secondaire d'une communauté macrobenthique de sable fin en baie de Morlaix"

## Etat initial

Tout d'abord, nous décrivons l'état initial non fairisé, juste après le
stage. 
### Description du projet 
_Se rapporter au rapport de stage pour le materiel et méthodes, contexte plus élaboré_

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

Quelle est la relation entre l’évolution de la production secondaire et
les changements de structure de la communauté de Pierre Noire ?

Pour répondre à cette question, nous avons comme données initiales : 
- Nom : Abondances et biomasses individuelles mars et octobre tous les ans
entre 2010 et 2022 
- Nom : Matrice de traits fonctionnels (incomplète) 
- Nom : Macroexcel Brey (à mettre sur github car standard) 

(mettre noms donnés aux tableaux (qu'on va mettre dans l'arborescence) mais qu'on ne
met pas sur github)

Mettre exemples / noms des colonnes (demander à clothilde la structure
et noms initiaux) 

```        
├── StageM1 
│ └── Données 
│     ├── Tableaufonctionnel
│     ├── MacroexcelBrey
│     ├── 

```

### Scripts / analyses initiaux

#### Calcul de la production

Production = Productivité/Biomasse moyenne ##### Calcul de la biomasse
D'après tableau 1 : 
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

### Output initiaux (peut etre pas besoins ?)

## Fairisation (de l'objectif \_ \_ \_)

Dans ce deuxième temps 
### Traçage des données initiales 
- PID de la zone
- PID de la station PN 
- PID SOMLIT - PID des auteurs (Sarah
Bureau) 
- PAS FAIRISABLE : Il manque les sources de la matrice de traits
fonctionnels, a été donnée telle quelle, a été complétée sans non plus
ajouter les sources au fur et à mesure, n'a pas indiqué les endroits qui
ont été estimés si rien n'a été trouvé dans le bibliographie

### Ajout de métadonnées

-   Taxons : Nom dans le tableau donné pour le stage M1, AlphaID et nom
    accepté (au 2 Décembre 2025) en important les noms scientifiques
    (Genre espèce) sur WoRMS

-   

    ### Structure / noms de fichiers

-   Nouvelle arborescence :
```
├── data 
│ └── test.csv 
  └── Scripts 
      ├── CorTProd.R 
      ├── Cor BioProdSomme.R 
      ├── CorrSpearman.R 
      ├──    KurskallWallis_boxplot.R 
      ├── PCoA Bio withoutrare.R
      └── PCoA Biomoy - Copie.R 
```    
    
### Scripts / analyse améliorés
    
-   Beaucoup de formatages et calculs manuels avec excel mais aurait mérité de le faire avec R pour augmenter la reproductibilité

-   Montrer les premières lignes des scripts améliorés avec leurs noms
    en haut comme ex du diapo
