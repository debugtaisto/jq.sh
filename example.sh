#!/usr/bin/env bash

. jq.sh

jqsource example.json

for a in $(jqdo "range(. | length)"); do
  jqpush ".[$a]"
    jqvar name url
    jqpush ".args"
      jqarg args
    jqpop
  jqpop
  
  echo "> Fetching $name"
  echo curl -I -L $args $url
  curl -I -L $args $url
done
