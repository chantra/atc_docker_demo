
# Install shaping script

```
docker exec -i atcdockerdemo_iperf_1 /bin/bash -c 'cat > /tmp/shaper.sh' < shaper.sh
```

Since docker 1.8 the file can be copied directly to the instance using:
```
docker cp shaper.sh atcdockerdemo_iperf_1:/tmp/shaper.sh
```
# Shape 100kB up/50kB down
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a shape -u 100 -d 50'
```

# Shape with delay 100ms up/50ms down
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a shape -L 100 -l 50'
```

# Shape with 10% packet loss up and 10% packet loss down
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a shape -X 10 -x 10'
```
# Unshape
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a unshape'
```
