data {
  int<lower=0> N; 
  int<lower=0> J; 
  int<lower=1,upper=J> county[N];
  vector[N] y;
  int<lower=0,upper=1> holdout[N];
} 
parameters {
  vector[J] a;
  real mu_a;
  real<lower=0> sigma_a;
  real<lower=0> sigma_y;
} 

model {
  vector[N] mu;
  
  // priors
  sigma_y ~ normal(0,1);
  sigma_a ~ normal(0,1);
  mu_a ~ normal(0,10);

  // likelihood  
  a ~ normal (mu_a, sigma_a);
  for(n in 1:N){
    mu[n] = a[county[n]];
    if(holdout[n] == 0){
      target += 
        normal_lpdf(y[n]|mu[n],sigma_y);
    }
  }
}
