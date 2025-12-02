#### Analyse statistique - Comparaison de la productivité (P/B) entre les différents groupes trophiques identifiés, sur l'ensemble de la période étudiée (2010-2022) ####

#### Représentation boxplot et test de Kruskal-Wallis ####
boxplot(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot,
        main = "Comparaison de la productivité entre les groupes trophiques",
        xlab = "Groupe trophique", ylab = "Productivité (en an-1)")

kruskal.test(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot)

#### Vérification des différences significatives entre les guildes trophiques - Test de Dunn avec correction de Holm ####
dunnTest(Prod ~ Groupe, data = PBDataFor_KruskallWallis_BoxPlot, method = "holm")
