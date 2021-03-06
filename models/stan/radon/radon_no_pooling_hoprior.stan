data {
  int<lower=0> N; 
  int<lower=0> J; 
  int<lower=1,upper=J> county[N];
  vector[N] x;
  vector[N] y;
  int<lower=0,upper=1> holdout[N];
} 

parameters {
  vector[J] a;
  real beta;
  real<lower=0> sigma_y;
} 

model {
  vector[N] mu;
  // Prior
  sigma_y ~ normal(0,1);
  a ~ normal(0,10);

  // Likelihood
  for(n in 1:N){
    mu[n] = beta*x[n] + a[county[n]];
    if(holdout[n] == 0){
      target += 
        normal_lpdf(y[n]|mu[n],sigma_y);
    }
  }
}

