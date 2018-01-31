This repository contains scripts for automated execution, stat calculation,
plotting, and report generation for RCX kernel-space hash table evaluation.


Simple Steps
============

First, edit or create a configuration file under `configs/` directory.  Then,
set `CFGF` environmental variable to the path of your config file.  If you do
not set the variable, `configs/default.sh` will be the configuration.  After
that, follow commands below.

```
$ for i in {1..5}; do ./run.sh; done
$ ./chk.sh
$ ./post.sh
```

The last command will generate human-readable report in html format at
`plots/<config name>/report-<config name>.html`.  `<config name>` is defined in
the configuration file.


Author
======

`SeongJae Park <sj38.park@gmail.com>`
