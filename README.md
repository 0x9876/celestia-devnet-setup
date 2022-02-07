## Celestia Devnet Setup

### Requirements

- docker-compose

### Usage

#### celestia-app

1.  Initialize configuration files, specifying a *moniker* (friendly name shown in block explorer) and a list of seeds:
    ```bash
    export MONIKER="my-moniker"
    export SEEDS="list,of,seeds"
    docker-compose run celestia_app_init
    ```
    The environment variables can also be declared in a `.env` file. Configuration files will be stored in a folder called `celestia_app`. Data will be stored in a docker volume called `celestia_app_data`.
1.  Run the app:
    ```bash
    docker-compose up celestia_app_start
    ```
    It should connect to the seeds (bootstrap peers) from which it will receive a list of peers. Once connected to one or more peers, synchronization should start. It might take a while before the app has caught up to the current block.

#### celestia-node

TODO
