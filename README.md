
# Install shaping script

```
docker exec -i atcdockerdemo_iperf_1 /bin/bash -c 'cat > /tmp/shaper.sh' < shaper.sh
```

# Shape 100kB up/50kB down
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a shape -u 100 -d 50'
```

# Shape with delay 100ms up/50ms down
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a shape -L 100 -l 50'
```

# Unshape
```
docker exec  atcdockerdemo_iperf_1  /bin/bash -c 'bash /tmp/shaper.sh -a unshape'
```
