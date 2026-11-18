# Install pixi
curl -fsSL https://pixi.sh/install.sh | bash

# Install global python env
pixi global install --environment python-env --expose python python
pixi global add --environment python-env tqdm
pixi global add --environment python-env matplotlib
pixi global add --environment python-env seaborn
