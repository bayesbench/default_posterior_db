data {
  int<lower=0> J; 
  int<lower=0> N; 
  int<lower=1,upper=J> county[N];
  vector[N] u;
  vector[N] x;
  vector[N] y;
} 
parameters {
  vector[J] a;
  real b1;
  real b2;
  real mu_a;
  real<lower=0,upper=100> sigma_a;
  real<lower=0,upper=100> sigma_y;
} 

model {
  mu_a ~ normal(0, 1);
  a ~ normal(mu_a, sigma_a);
  b1 ~ normal(0, 1);
  b2 ~ normal(0, 1);
  y ~ normal(a[county] + b1*x + b2*u, sigma_y);
}

