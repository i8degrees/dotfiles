#!/bin/bash
#
# 2016-02/15:jeff
#
# Local setup for scorpio.local
#
# NOTE(jeff): This file is sourced from bash_profile

# The number of CPU threads to spawn for development tools (make, CTest, etc.)
NUM_THREADS=6 # Intel Core i7-4790K @ 4.00GHz "Devil's Canyon"
MAKEFLAGS="-j${NUM_THREADS}"; export MAKEFLAGS
CTEST_PARALLEL_LEVEL=$((NUM_THREADS+2)); export CTEST_PARALLEL_LEVEL
