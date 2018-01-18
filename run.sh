#!/bin/bash
# Usage: /path/to/run.sh "v1.4 v1.5 v1.6 master'

versions=$1
run_exs=${0/.sh/.exs}

for v in $versions; do
  git checkout $v
  make clean compile
  elixir $run_exs > modules-$v.md
done
