data {
  int<lower=0> J; 
  int<lower=0> N; 
  int<lower=1,upper=J> county[N];
  vector[N] x;
  vector[N] y;
  int<lower=0,upper=1> holdout[N];
} 
parameters {
  real a;
  vector[J] beta;
  real mu_beta;
  real<lower=0> sigma_beta;
  real<lower=0> sigma_y;
} 

model {
  vector[N] mu;
  // Prior
  a ~ normal(0,10);
  sigma_y ~ normal(0,1);
  sigma_beta ~ normal(0,1);
  mu_beta ~ normal(0,10);

  beta ~ normal(mu_beta,sigma_beta);
  for(n in 1:N){
    mu[n] = a + x[n] * beta[county[n]];
    if(holdout[n] == 0){
      target += 
        normal_lpdf(y[n]|mu[n],sigma_y);
    }
  }
}
