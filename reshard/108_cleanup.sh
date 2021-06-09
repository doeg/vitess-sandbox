#!/bin/bash

source ./env.sh

for i in 100 101 102; do
	CELL=zone1 TABLET_UID=$i ./scripts/vttablet-down.sh
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-down.sh
done

vtctlclient DeleteShard -recursive fauna/0
vtctlclient Workflow fauna.reshard_-80_80-
vtctlclient Workflow fauna.reshard_-80_80-_reverse
