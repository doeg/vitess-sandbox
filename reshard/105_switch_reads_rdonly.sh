#!/bin/bash

source ./env.sh

vtctlclient SwitchReads -tablet_type=rdonly fauna.reshard_-80_80-