#!/bin/sh

cd vagrant && vagrant snapshot list | while read line; do vagrant snapshot restore --no-provision $line $line; done
