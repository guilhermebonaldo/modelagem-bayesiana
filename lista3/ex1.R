setwd("~/Mestrado IME/Modelagem bayesiana/P2/lista3")

yj = c(28,8,-3,7,-1,1,18,12)
varj = c(15,10,16,11,9,11,10,18)

var = mean(varj)

# valores iniciais
# ele identifica o que eh dado e o que eh parametro
ini = list(mu = 1, T = 0.1)

# parametros para monitorar
params = c("mu","T")

MLS.fit = bugs(
  
  data = list("yj", "var"),
  inits = list(ini),
  parameters.to.save = params,
  model.file = "modelex1.txt",
  n.chains = 1,
  n.iter = 3000,
  n.burnin = 2000,
  debug = FALSE,
  save.history = FALSE,
  DIC = TRUE
  
)

MLS.fit$summary
# o valor do dic nao indica nada, apenas quando comparado com outros dic
MLS.fit$DIC
# complexidade do modelo - numero efetivo de parametros
MLS.fit$pD


# preparando os dados para uso no coda
r = MLS.fit$sims.matrix
r_mcmc = as.mcmc(r)

# graficos

# convergencia mcmc
plot(r_mcmc[,1])
plot(r_mcmc[,2])

