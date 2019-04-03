data {
  int<lower=0> N; 
  vector[N] x;
  vector[N] y;
  int<lower=0,upper=1> holdout[N];
}

parameters {
  vector[2] beta;
  real<lower=0> sigma_y;
} 

model {
  vector[N] mu;
  
  // priors
  sigma_y ~ normal(0,1);
  beta ~ normal(0,10);

  // likelihood  
  mu = beta[1] + beta[2] * x;
  for(n in 1:N){
    if(holdout[n] == 0){
      target += 
        normal_lpdf(y[n]|mu[n],sigma_y);
    }
  }
}

