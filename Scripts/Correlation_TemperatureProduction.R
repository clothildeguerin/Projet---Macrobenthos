########################################################
# Description :  Analyse statistique - 
#               Corrélation entre la production secondaire et la température.
# Nom : Correlation_TemperatureProduction.R
# Auteur : Clothilde GUERIN (PID = ...)
# Date : 3 Décembre 2025
########################################################
#Chargement des données
CorrelationData_TProd <- read.csv("data/CorrelationData_TProd.csv", check.names = FALSE)
#Check names évite la transformation des espace et parenthèses dans le nom
#des colonnes d'être transformées en points, ce qui faisait bug la suite

#### Représentation graphique ####
couleurs <- as.factor(CorrelationData_TProd$Année)
palette_couleurs <- rainbow(length(levels(couleurs)))
plot(x = CorrelationData_TProd$`Température (°C)`,
     y = CorrelationData_TProd$`Production (g.m-2.an-1)`, 
     xlab="Température (°C)", 
     ylab="Production (g.m-2.an-1)",
     col = palette_couleurs[couleurs],
     pch = 19)
legend("topleft", legend = levels(couleurs),
       col = palette_couleurs, pch = 19, title = "Année", cex = 0.9)

#### Analyse : régression linéaire entre la production secondaire et la température ####
reg = lm(`Production (g.m-2.an-1)`~`Température (°C)`, data=CorrelationData_TProd)
summary(reg)
abline(reg, col="red")

# Extraction des coefficients, résidus et valeurs prédites
reg$coefficients
reg$fitted.values
reg$residuals

# Représentations graphique des conditions d'application
par(mfrow=c(2,2))
plot(reg)