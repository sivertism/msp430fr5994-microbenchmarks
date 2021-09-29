#
# Copyright (c) 2019-2020, University of Southampton and Contributors.
# All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

 cmake_minimum_required(VERSION 3.13)

set(TARGET_ARCH "msp430")

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/cmake/msp430-toolchain.cmake)

project(msp430fr5994-microbenchmarks)

option(SIMULATION "Enable simulation control (SIMPLE_MONITOR)" OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/common.cmake)

include_directories(support)
include_directories(../include)
include_directories(.)

add_subdirectory(support)
add_subdirectory(microbenchmarks)
