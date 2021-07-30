attach(election)

str(election)

y=sqrt(buchanan)
x = sqrt(perot)

N=length(y)

ini = list(b = c(0,0), tau = 1, lambda = rep(1,N))

params = c('b', 'tau', 'lambda')

MLS.fit = bugs(
  
  data = list("y", "x", "N"),
  inits = list(ini),
  parameters.to.save = params,
  model.file = "model.txt",
  n.chains = 1,
  n.iter = 3000,
  n.burnin = 2000,
  debug = TRUE,
  save.history = FALSE,
  DIC = TRUE
  
)