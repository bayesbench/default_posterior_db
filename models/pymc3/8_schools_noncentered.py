import pymc3 as pm

def model(eight_school_data):
    with pm.Model() as pm_model:
        mu = pm.Normal('mu', mu=0, sd=5)
        tau = pm.HalfCauchy('tau', beta=5)
        theta_tilde = pm.Normal('theta_tilde', mu=0, sd=1, shape=eight_school_data['J'])
        theta = pm.Deterministic('theta', mu + tau * theta_tilde)
        pm.Normal('obs', mu=theta, sd=eight_school_data['sigma'], observed=eight_school_data['y'])
    return pm_model
