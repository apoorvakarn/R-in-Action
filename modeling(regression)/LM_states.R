# ANOVA (highest R2 value and low p value (>0.05))----
(state.x77)
class(state.x77)
str(state.x77)
head(state.x77)
?state.x77
states = as.data.frame(state.x77)
attach(states)
fit1 = lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
fit1
(fit2 = lm(Murder ~ Population + Illiteracy, data = states))
str(states)
anova(fit2,fit1)
summary(fit1)
summary(fit2)
# aic----
AIC(fit1,fit2) #smaller aic values----
