

docker exec -i atcdockerdemo_iperf_1 /bin/bash -c 'cat > /tmp/shaper.sh' < shaper.sh


docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'DOWN=150 sh /tmp/shaper.sh'
