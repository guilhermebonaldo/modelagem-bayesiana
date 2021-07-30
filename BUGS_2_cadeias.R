# simulando os dados
N = 500
x = runif(N,-1,1)
eps = rnorm(N)
y = x+eps

# valores iniciais
# 
ini1 = list(b = c(0,0), tau = 1)
ini2 = list(b = c(-1,-1), tau = 0.5)

# parametros para monitorar
params = c("b","tau")

MLS.fit = bugs(
  
  data = list("x", "y", "N"),
  inits = list(ini1, ini2),
  parameters.to.save = params,
  model.file = "model1.txt",
  n.chains = 2,
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


# como temos uma cadeia com 3000 valores - 2000 burnin = 1000 valores
# cada lista inicial tem 1000 valores portanto
# preparando os dados para uso no coda
r = MLS.fit$sims.matrix
r1 = as.mcmc(r[1:1000,])
r2 = as.mcmc(r[1001:2000,])

r_mcmc = as.mcmc.list(list(r1,r2))

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

gelman.diag(list(r1,r2))

# como 1 = 0.5, estamos monitorando a mediana
# indica quantas amostras precisamos para a estimacao que queremos
raftery.diag(r1[1:1000], q = 0.5, r = 0.05, s = 0.95, converge.eps = 0.001)
raftery.diag(r2[1:1000], q = 0.5, r = 0.05, s = 0.95, converge.eps = 0.001)


# tamanho efetivo da amosta, 
# que resultaria em um estimados com o mesmo erro padrao (variancia)
# quanto mais perto do real, mais perto da amostra dependente
effectiveSize(r1)
effectiveSize(r2)

HPDinterval(r1, prob = 0.95)

