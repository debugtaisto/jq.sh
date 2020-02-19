#!/usr/bin/env bash

. jq.sh

jqsource example.json

for a in $(jqdo "range(. | length)"); do
  jqpush ".[$a]"
    jqvar name url
  jqpop
  
  echo "> Fetching $name ($url)"
  curl -I -L $url
done
