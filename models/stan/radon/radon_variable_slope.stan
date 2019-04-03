data {
  int<lower=0> J; 
  int<lower=0> N; 
  int<lower=1,upper=J> county[N];
  vector[N] x;
  vector[N] y;
} 
parameters {
  real a;
  vector[J] b;
  real mu_b;
  real<lower=0,upper=100> sigma_b;
  real<lower=0,upper=100> sigma_y;
} 

model {
  sigma_b ~ uniform(0, 100);
  b ~ normal (mu_b, sigma_b);
  a ~ normal (0, 1);
  sigma_y ~ uniform(0, 100);
  
  for (i in 1:N)
    y[i] ~ normal(a + x[i] * b[county[i]], sigma_y);
}
