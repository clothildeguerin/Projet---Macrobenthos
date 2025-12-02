couleurs <- as.factor(Cor_BioProdg_Somme$Année)
palette_couleurs <- rainbow(length(levels(couleurs)))


plot(x = Cor_BioProdg_Somme$Bio_totale, y = Cor_BioProdg_Somme$Production_sec_totale, xlab="Biomasse totale (g.m-2)", ylab="Production secondaire totale (g.m-2.an-1)",
     col = palette_couleurs[couleurs],
     pch = 19)

legend("topleft", legend = levels(couleurs),
       col = palette_couleurs, pch = 19, title = "Année", cex = 0.9)

reg = lm(Production_sec_totale~Bio_totale, data=Cor_BioProdg_Somme)
summary(reg)

par(mfrow=c(2,2))
plot(reg)

abline(reg, col="red")

reg$coefficients
reg$fitted.values
reg$residuals

shapiro.test(reg$residuals)
# pvalue de 0.09, normalité validée mais de peu


