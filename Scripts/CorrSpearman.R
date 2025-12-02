#corr de spearman non paramétrique donc pas besoin
#que les variables soient distribuées normalement, ou linéaires
#y'a juste un risque que les valeurs extrêmes influencent le tout 

cor.test(Cor_BioProdg_Somme$Bio_totale, Cor_BioProdg_Somme$Production_sec_totale, method = "spearman")

library(ggplot2)

Cor_BioProdg_Somme$Année <- as.factor(Cor_BioProdg_Somme$Année)
str(Cor_BioProdg_Somme)

ggplot(Cor_BioProdg_Somme, aes(x = Bio_totale , y = Production_sec_totale, color = as.factor(Année))) +
  geom_point(size = 3) +  # points
  labs(title = "Relation entre la biomasse et la production secondaire",
       x = "Biomasse (en g.m-2)",
       y = "Production secondaire (en g.m-2.an-1)",
       color = "Année") +
  theme_minimal() +
  theme(legend.text = element_text(size=14))
