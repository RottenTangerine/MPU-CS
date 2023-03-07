#!/bin/sh

curl -i -H "Accept: application/json" -H "Content-Type: application/json" 10.0.0.$1/api/v1.0/getRange/$2/$3 -X GET
