
yj = c(28,8,-3,7,-1,1,18,12)

# valores iniciais
# ele identifica o que eh dado e o que eh parametro
ini = list(mu2 = 1, tau = 1)

# parametros para monitorar
params = c("mu2","tau")

MLS.fit = bugs(
  
  data = list("yj"),
  inits = list(ini),
  parameters.to.save = params,
  model.file = "modelex1.txt",
  n.chains = 1,
  n.iter = 3000,
  n.burnin = 2000,
  debug = TRUE,
  save.history = FALSE,
  DIC = TRUE
  
)

MLS.fit$summary
# o valor do dic nao indica nada, apenas quando comparado com outros dic
MLS.fit$DIC
# complexidade do modelo - numero efetivo de parametros
MLS.fit$pD



# item C

