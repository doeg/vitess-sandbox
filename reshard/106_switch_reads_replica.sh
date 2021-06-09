#!/bin/bash

source ./env.sh

vtctlclient SwitchReads -tablet_type=replica fauna.reshard_-80_80-