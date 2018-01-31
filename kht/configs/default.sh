# Small configuration for test of automation itself

config_name="default"

benchs="rcuhashlist"

duration="1500"

nodes_per_buck="128"

# RLU hangs with 1 bucket / 1 node / multiple threads...
#nr_bucks="1 128 256"
nr_bucks="1"

wrates="0 200"

# System hangs with 144 thread benchmark...
#nr_threads="1 2 4 9 18 36 54 72 90 108 126  144"
nr_threads="1 2"
