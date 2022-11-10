#!/bin/bash -e

export EXPERIMENT_NAME="try-freetype2"

PYTHONPATH=. python3 experiment/run_experiment.py \
 -a\
 --experiment-config ../RevBugBench/fuzzbench/experiment-config.yaml \
 --benchmarks freetype2-2017 \
 --experiment-name $EXPERIMENT_NAME \
 --fuzzers afl libfuzzer

