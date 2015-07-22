#!/bin/bash

GW=$(ip r | grep default | awk '{print $3}')
URI=/api/v1/shape/
#ENDPOINT=http://${GW}:8000/api/v1/shape/


UP=${UP:-500}
DOWN=${DOWN:-500}

content="
{
  \"up\": {
    \"rate\": \"${UP}\",
    \"delay\": {
      \"delay\": 0,
      \"jitter\": 0,
      \"correlation\": 0
    },
    \"loss\": {
      \"percentage\": 0,
      \"correlation\": 0
    },
    \"reorder\": {
      \"percentage\": 0,
      \"correlation\": 0,
      \"gap\": 0
    },
    \"corruption\": {
      \"percentage\": 0,
      \"correlation\": 0
    },
    \"iptables_options\": []
  },
  \"down\": {
    \"rate\": \"${DOWN}\",
    \"delay\": {
      \"delay\": 0,
      \"jitter\": 0,
      \"correlation\": 0
    },
    \"loss\": {
      \"percentage\": 0,
      \"correlation\": 0
    },
    \"reorder\": {
      \"percentage\": 0,
      \"correlation\": 0,
      \"gap\": 0
    },
    \"corruption\": {
      \"percentage\": 0,
      \"correlation\": 0
    },
    \"iptables_options\": []
  }
}"


cat <<EOF | nc ${GW} 8000
POST ${URI} HTTP/1.0
Content-Type: application/json
Accept: application/json; indent=2
Content-Length: ${#content}

${content}
EOF
