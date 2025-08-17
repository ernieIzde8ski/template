import json

try:
    import yaml
except ModuleNotFoundError:
    import sys

    print("ERROR: `pyyaml` not found.", file=sys.stderr)
    sys.exit(1)

with open("cookiecutter.yaml", "r") as source:
    obj: object = yaml.full_load(source)

with open("cookiecutter.json", "w+") as target:
    json.dump(obj, target)
