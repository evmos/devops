# Dev Ops Take Home Challenge

In this repo we are giving you a simple docker-compose setup that starts two different evmos devnets running on different versions / releases using the instructions found below.

- `evmos-devnet1`: v9.1.0
- `evmos-devnet2`: v10.0.1

The mission is for you to expand the functionalities of this repo to accomplish the following tasks:

1. Set up a Grafana dashboard instance through the same docker-compose setup, in which instance specific metrics of each of the nodes are displayed and can be compared (CPU, Memory etc..)
2. Expose some of the prometheus metrics that each node provides at `http://localhost:26660/metrics` through the Grafana dashboard. (e.g `feemarket_base_fee` is one that we are usually interested on)
3. (Optional) In order to get more interesting data, Add a tx-bot to the docker-compose setup so that it generates traffic on the node’s network. You can find the tx-bot repo [here](https://github.com/evmos/bots)

## Run

To run the localnet setup, start the docker containers (defined in [docker-compose.yml](https://github.com/facs95/devops/blob/main/docker-compose.yml)) using

```bash
docker-compose up --build -d
```

This will run the containers in the background. If you want to see all logs immediately, omit the `-d` flag. To inspect all logs, run

```bash
docker-compose logs -f
```

To get the log outputs for individual services (e.g. the individual Evmos nodes), you can specify the service to be printed to the terminal output by adding this as an argument to the `docker compose logs` command, e.g.

```bash
docker-compose logs evmos-devnet1 -f
```

If you want to stop the execution of the testing setup, use

```bash
docker-compose down --volumes
```

## Customize

You can update the commits to be tested by updating `commit_hash` for `evmos-devnet1` and `evmos-devnet2` in `docker-compose.yml`.

## Tx-bot

In case you decide to do the extra credit, here is some helpful information.

Instructions on how to run can be found on the bots repo [here](https://github.com/evmos/bots).

You will need to run one tx-bot per devnet.

- `tx-bot1` submits txs to `evmos-devnet1`
- `tx-bot2` submits txs to `evmos-devnet2`

In order to run the bot successfully you would need two Environment Variables.

1. `ORCH_PRIV_KEY` - In order to submit txs on the network, you need an account that has funds for those transactions. This address is specified in the `start.sh` file that starts the `evmos-devnet` represented as a `MNEMONIC`. Since both devnets (`evmos-devnet1` and `evmos-devnet2`) are started with the same `start.sh` file, we can use the same private key for both instances of the tx-bots.

- `ORCH_PRIV_KEY=0x1c384b3fb9a1cff8caee1e2d078bb9bc28a542dcc7ac779a445dc68b3dc2fe1f`

2. `RPC_URL` - We need to tell the bot hot to connect with the respective devnet it is supposed to send transactions to. The bot uses our JSON-RPC API which is exposed on port `8545`.

- `RPC_URL=http://$NODE_ADDRESS:8545`

