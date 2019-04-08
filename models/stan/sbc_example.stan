data {
  int<lower = 1> N;
  real<lower = 0> a;
  real<lower = 0> b;
  int<lower = 0> y;
}
parameters {
  real<lower = 0, upper = 1> pi;
}
model {
  target += beta_lpdf(pi | a, b);
  target += binomial_lpmf(y | N, pi);
}
generated quantities {
  real pi_ = beta_rng(a, b);
  int y_ = binomial_rng(N, pi_);
}