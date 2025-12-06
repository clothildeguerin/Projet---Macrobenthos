couleurs <- as.factor(Cor_TProd$Année)
palette_couleurs <- rainbow(length(levels(couleurs)))



plot(x = Cor_TProd$`Température (°C)`, y = Cor_TProd$`Production (g.m-2.an-1)`, xlab="Température (°C)", ylab="Production (g.m-2.an-1)",
     col = palette_couleurs[couleurs],
     pch = 19)

legend("topleft", legend = levels(couleurs),
       col = palette_couleurs, pch = 19, title = "Année", cex = 0.9)

reg = lm(`Production (g.m-2.an-1)`~`Température (°C)`, data=Cor_TProd)
summary(reg)
abline(reg, col="red")

reg$coefficients
reg$fitted.values
reg$residuals

par(mfrow=c(2,2))
plot(reg)

shapiro.test(reg$residuals)
bartlett.test(reg$residuals ~ Cor_TProd)