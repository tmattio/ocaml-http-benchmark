#!/bin/sh

set -e

run_bench () {
  echo "Executing benchmarks in $1 ($2), saving results to $3."
  cd "benchmark/$1" || exit

  opam exec -- dune exec "src/$2.exe" &
  pid=$!

  # Wait for the server to start
  sleep 1

  wrk2 \
    -t8 -c10000 -d60S \
    --timeout 2000 \
    -R 30000 --latency \
    -H 'Connection: keep-alive' \
    http://localhost:8000/ \
    > "../../result/$3" 2>&1

  kill $pid

  cd ../.. || exit
}

# run_bench "cohttp-2.5" "cohttp_lwt" "cohttp-lwt-2.5.log"
# run_bench "cohttp-3.0" "cohttp_lwt" "cohttp-lwt-3.0.log"
# run_bench "httpaf" "httpaf_lwt" "httpaf-lwt.log"
# run_bench "httpaf" "httpaf_lwt_bigstring" "httpaf-lwt-bigstring.log"
# run_bench "httpaf-fork" "httpaf_lwt" "httpaf-fork-lwt.log"
run_bench "httpaf-fork" "httpaf_lwt_bigstring" "httpaf-fork-lwt-bigstring.log"
