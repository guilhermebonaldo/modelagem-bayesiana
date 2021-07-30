y = c(29,26,54,30,16,15,6,35,17,7,43,17,15,11,11,2,2,9,2,3,11,5,2)
E = c(10.71,17.99,18.17,19.21, 21.96,14.63,9.62,17.27,18.82,18.27,32.18,24.59,8.40,15.64,11.83,9.95,10.83,18.34,5.18,10.95,20.01,13.83,12.79)


# valores iniciais
# ele identifica o que eh dado e o que eh parametro
ini = list(lambda0 = 2 , pre = 1)

# parametros para monitorar
params = c("lambda", "var")#pre

MLS.fit = bugs(
  
  data = list("y", "E"),
  inits = list(ini),
  parameters.to.save = params,
  model.file = "model3a.txt",
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
plot(r_mcmc[,3])

# autocorrelacao dos valores da cadeia
autocorr.plot(r_mcmc[,1:2])
autocorr.plot(r_mcmc[,3])

# faz a media movel com intervalo 90%
cumuplot(r_mcmc[,1:2])
cumuplot(r_mcmc[,3])

# se os parametros forem mt correlacionados, 
#vale fazer uma transformacao no parametro (padronizar o X)
crosscorr(r_mcmc)
# baseado em uma cadeia
#separa a cadeia em duas partes e realiza um teste de comparacao de medias
#valores altos de Z indicam a rejeicao da hipotese de igualdade de media
geweke.diag(r_mcmc)

# tamanho efetivo da amosta, 
# que resultaria em um estimados com o mesmo erro padrao (variancia)
# quanto mais perto do real, mais perto da amostra dependente
effectiveSize(r_mcmc)

HPDinterval(r_mcmc, prob = 0.95)

