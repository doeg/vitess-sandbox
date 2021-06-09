#!/bin/bash

source ./env.sh

keyspace="fauna"

CELL=zone1 ./scripts/etcd-up.sh

CELL=zone1 ./scripts/vtctld-up.sh

# fauna keyspace
for i in 100 101 102; do
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-up.sh
	CELL=zone1 KEYSPACE=$keyspace TABLET_UID=$i ./scripts/vttablet-up.sh
done

vtctldclient InitShardPrimary --force fauna/0 zone1-100

vtctlclient ApplySchema -sql-file 101_fauna_schema.sql fauna
vtctlclient ApplyVSchema -vschema_file 101_fauna_vschema.json fauna

# lookup keyspace
for i in 200 201 202; do
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-up.sh
	CELL=zone1 KEYSPACE="lookup" TABLET_UID=$i ./scripts/vttablet-up.sh
done

vtctldclient InitShardPrimary --force lookup/0 zone1-200

vtctlclient ApplySchema -sql-file 101_lookup_schema.sql lookup
vtctlclient ApplyVSchema -vschema_file 101_lookup_vschema.json lookup

# start vtgate
CELL=zone1 ./scripts/vtgate-up.sh
