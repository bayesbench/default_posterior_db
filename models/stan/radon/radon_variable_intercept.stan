data {
  int<lower=0> J; 
  int<lower=0> N; 
  int<lower=1,upper=J> county[N];
  vector[N] x;
  vector[N] y;
} 
parameters {
  vector[J] a;
  real b;
  real mu_a;
  real<lower=0,upper=100> sigma_a;
  real<lower=0,upper=100> sigma_y;
} 

model {
  sigma_a ~ uniform(0, 100);
  a ~ normal (mu_a, sigma_a);
  b ~ normal (0, 1);

  sigma_y ~ uniform(0, 100);
  for (i in 1:N)
    y[i] ~ normal(a[county[i]] + x[i] * b, sigma_y);
}
