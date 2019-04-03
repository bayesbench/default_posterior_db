data {
  int<lower=0> N;
  int<lower=0> J;
  vector[N] y;
  vector[N] x;
  int county[N];
  int<lower=0,upper=1> holdout[N];
}
parameters {
  real<lower=0> sigma_y;
  real<lower=0> sigma_a;
  real<lower=0> sigma_beta;
  vector[J] a;
  vector[J] beta;
  real mu_a;
  real mu_beta;
}

model {
  vector[N] mu;
  // Prior
  sigma_y ~ normal(0,1);
  sigma_beta ~ normal(0,1);
  sigma_a ~ normal(0,1);
  mu_a ~ normal(0,10);
  mu_beta ~ normal(0,10);

  a ~ normal(mu_a, sigma_a);
  beta ~ normal(mu_beta, sigma_beta);
  for(n in 1:N){
    mu[n] = a[county[n]] + x[n]*beta[county[n]];
    if(holdout[n] == 0){
      target += 
        normal_lpdf(y[n]|mu[n],sigma_y);
    }
  }
  
}
