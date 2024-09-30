# Instructions to run tests

dmesg on the host system must be unrestricted:
```
sudo sysctl -w kernel.dmesg_restrict=0
```


```
. env/configure

# Run mmtests
run.sh -m

# ...or Run lkp
run.sh -l
```
