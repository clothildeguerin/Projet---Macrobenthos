boxplot(Prod ~ Groupe, data = KW_BoxPlot,
        main = "Comparaison de la productivité entre les groupes trophiques, sur toute la période",
        xlab = "Groupe trophique", ylab = "Productivité (en an-1)")

kruskal.test(Prod ~ Groupe, data = KW_BoxPlot)

library(FSA)

dunnTest(Prod ~ Groupe, data = KW_BoxPlot, method = "holm")
