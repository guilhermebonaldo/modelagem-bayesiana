y = c(29,26,54,30,16,15,6,35,17,7,43,17,15,11,11,2,2,9,2,3,11,5,2)
E = c(10.71,17.99,18.17,19.21, 21.96,14.63,9.62,17.27,18.82,18.27,32.18,24.59,8.40,15.64,11.83,9.95,10.83,18.34,5.18,10.95,20.01,13.83,12.79)


# valores iniciais
# ele identifica o que eh dado e o que eh parametro
ini = list(lambda0 = 2 , pre = 0.01)

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
  debug = TRUE,
  save.history = FALSE,
  DIC = TRUE
  
)


