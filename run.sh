#!/bin/bash
# Usage: /path/to/run.sh
#
# Run from within git repository.

versions="v1.0 v1.1 v1.2 v1.3 v1.4 v1.5 v1.6 master"
pairs="v1.0,v1.1 v1.1,v1.2 v1.3,v1.4 v1.4,v1.5 v1.5,v1.6 v1.6,master"
run_exs=${0/.sh/.exs}

for v in $versions; do
  git checkout $v
  make clean compile
  elixir $run_exs > modules-$v.txt
done

for pair in $pairs; do
  IFS=',' read -r -a array <<< "$pair"
  left=${array[0]}
  right=${array[1]}
  git diff --no-index modules-${left}.txt modules-${right}.txt > diff-${left}-${right}.txt.diff
done
