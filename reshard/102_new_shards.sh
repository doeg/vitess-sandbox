#!/bin/bash

source ./env.sh

keyspace="fauna"

for i in 300 301 302; do
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-up.sh
	SHARD=-80 CELL=zone1 KEYSPACE=$keyspace TABLET_UID=$i ./scripts/vttablet-up.sh
done

for i in 400 401 402; do
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-up.sh
	SHARD=80- CELL=zone1 KEYSPACE=$keyspace TABLET_UID=$i ./scripts/vttablet-up.sh
done

vtctldclient InitShardPrimary --force fauna/-80 zone1-300
vtctldclient InitShardPrimary --force fauna/80- zone1-400