#
# Copyright (c) 2019-2020, University of Southampton and Contributors.
# All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# Force compiler detection so we can set up flags
enable_language(C ASM)

IF(${SIMULATION})
  add_compile_options(-DSIMULATION)
ENDIF()

include_directories($ENV{MSP430_INC}/include) # MSP430 headers

add_compile_options(
    -DMSP430_ARCH
    -std=c99
    -mcpu=msp430
    -msmall
    -mhwmult=f5series # none
    -fno-common
    -Wall
    -fno-zero-initialized-in-bss
    )

# Linker scripts
set(LSCRIPTS "-T$ENV{MSP430_INC}/include/msp430fr5994_symbols.ld")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LSCRIPTS}")

link_directories(
    $ENV{MSP430_GCC_ROOT}/msp430-elf/lib/430/
    $ENV{MSP430_GCC_ROOT}/lib/gcc/msp430-elf/8.2.0/430
    $ENV{MSP430_INC}/include
    )

link_libraries( # Global link flags
    # Removing standard libs and startup code to prevent unnecessary initialization
    #-nostartfiles
    #-nodefaultlibs
    -nostdlib
    -ffreestanding
    )

# Utility for linking targets to std libs
set(SUPPORT_LIBS mul_f5 gcc c)
