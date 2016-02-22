#!/bin/bash
#
# 2016-02/14:jeff
#
# Local setup for libra.local
#
# NOTE(jeff): This file is sourced from bash_profile

# The number of CPU threads to spawn for development tools (make, CTest, etc.)
NUM_THREADS=1  # Intel Atom
export MAKEFLAGS="-j${NUM_THREADS}"
export CTEST_PARALLEL_LEVEL=${NUM_THREADS}
