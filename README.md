# Description
- This Dockerfile implements the following environment:
  - rust language
  - cargo contract
  - node.js
  - npm
  - yarn
  - swanky

# How To Use
1. Please install docker in your environment.
1. Build docker image.
1. Create a docker container.
1. Enter into the container & build a WASM smart contract.

# Command Example
```
docker image build . -t astar_dev_env_v1
docker run -it -d -p 9944:9944 --name astar-dev astar_dev_env_v1
docker exec -it astar-dev /bin/bash
```

# Example Of Starting Swanky Node
```
./swanky-node --dev --tmp --ws-external
```

# Example Of Copying the file in docker container
```
docker cp 52e781bfaa38:/home/developer/flipper/target/ink/flipper.contract ./flipper.contract
```

