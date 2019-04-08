import yaml
import os

model_names = """radon_hiearchical_intercept2_hoprior
radon_partial_pooling2_hoprior
radon_variable_intercept_slope2_hoprior
radon_hiearchical_intercept2
radon_partial_pooling2
radon_variable_intercept_slope2""".split(
    "\n"
)


dataset_names = ["radon", "radon_mn"]

runs = []

for model_name in model_names:
    for dataset_name in dataset_names:
        if dataset_name == "radon_mn":
            posterior_name = model_name.replace("radon", "radon_mn")
        else:
            posterior_name = model_name
        runs.append(
            {
                "model_name": model_name,
                "dataset_name": dataset_name,
                "posterior_name": posterior_name,
            }
        )

yaml_contents = yaml.dump(runs)

output_dir = os.path.dirname(os.path.abspath(__file__))

output_path = os.path.join(output_dir, "config.yaml")

with open(output_path, "w") as f:
    f.write(yaml_contents)

print(yaml.dump(runs))

