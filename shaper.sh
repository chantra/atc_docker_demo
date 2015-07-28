#!/bin/bash

GW=$(ip r | grep default | awk '{print $3}')
URI=/api/v1/shape/
#ENDPOINT=http://${GW}:8000/api/v1/shape/


UP=${UP:-0}
DOWN=${DOWN:-0}
UP_DELAY=${UP_DELAY:-0}
DOWN_DELAY=${DOWN_DELAY:-0}
ACTION=${ACTION:-"shape"}

while getopts ":a:u:d:Dl:L:" opt; do
    case $opt in
        a)
            ACTION="${OPTARG}"
            ;;
        u)
            UP="${OPTARG}"
            ;;
        d)
            DOWN="${OPTARG}"
            ;;
        l)
            DOWN_DELAY="${OPTARG}"
            ;;
        L)
            UP_DELAY="${OPTARG}"
            ;;
        D)
            set -x
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

function shape {
    up=$1
    down=$2
    content="
{
  \"up\": {
    \"rate\": \"${up}\",
    \"delay\": {
      \"delay\": ${UP_DELAY},
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
    \"rate\": \"${down}\",
    \"delay\": {
      \"delay\": ${DOWN_DELAY},
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
}

function unshape {
    cat <<EOF | nc ${GW} 8000
DELETE ${URI} HTTP/1.0
Content-Type: application/json
Accept: application/json; indent=2

EOF

}

if [ "${ACTION}" == "shape" ]; then
    shape "$UP" "$DOWN"
elif [ "${ACTION}" == "unshape" ]; then
    unshape
fi

exit 0

