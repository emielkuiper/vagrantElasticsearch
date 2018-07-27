#!/bin/sh

cd vagrant && vagrant status | grep running | awk '{print $1}' | while read line; do vagrant snapshot save $line $line; done
