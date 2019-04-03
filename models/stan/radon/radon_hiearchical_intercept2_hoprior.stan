data {
  int<lower=0> J; 
  int<lower=0> N; 
  int<lower=1,upper=J> county[N];
  vector[N] u;
  vector[N] x;
  vector[N] y;
  int<lower=0,upper=1> holdout[N];
} 
parameters {
  vector[J] a;
  vector[2] beta;
  real mu_a;
  real<lower=0> sigma_a;
  real<lower=0> sigma_y;
} 
transformed parameters {
}

model {
  vector[N] mu;
  vector[N] m;

  sigma_a ~ normal(0, 1);
  sigma_y ~ normal(0, 1);
  mu_a ~ normal(0, 10);
  beta ~ normal(0, 10);

  a ~ normal(mu_a, sigma_a);
  for(n in 1:N){
    m[n] = a[county[n]] + u[n] * beta[1];
    mu[n] = m[n] + x[n] * beta[2];
    if(holdout[n] == 0){
      target += normal_lpdf(y[n] | mu[n], sigma_y);
    }
  }
}

