data {
  int<lower=0> N; 
  int<lower=0> J; 
  int<lower=1,upper=J> county[N];
  vector[N] x;
  vector[N] y;
} 
parameters {
  vector[J] a;
  real beta;
  real<lower=0,upper=100> sigma;
} 
transformed parameters {
  vector[N] y_hat;

  for (i in 1:N)
    y_hat[i] = beta * x[i] + a[county[i]];
}
model {
  y ~ normal(y_hat, sigma);
}

