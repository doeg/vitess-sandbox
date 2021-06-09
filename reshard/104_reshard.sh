#!/bin/bash

source ./env.sh

vtctlclient Reshard fauna.reshard_-80_80- '0' '-80,80-'
