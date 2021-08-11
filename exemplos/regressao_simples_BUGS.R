install.packages("R2OpenBUGS")
install.packages("coda")


# programa RLS-BUGS

# simulando os dados
N = 500
x = runif(N,-1,1)
eps = rnorm(N)
y = x+eps

# valores iniciais
# ele identifica o que eh dado e o que eh parametro
ini = list(b = c(0,0), tau = 1)

# parametros para monitorar
params = c("b","tau")

MLS.fit = bugs(
  
  data = list("x", "y", "N"),
  inits = list(ini),
  parameters.to.save = params,
  model.file = "model1.txt",
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
plot(r_mcmc[,1:2])
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


r_mcmc









