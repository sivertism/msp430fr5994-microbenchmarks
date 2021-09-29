#
# Copyright (c) 2019-2020, University of Southampton and Contributors.
# All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

cmake_minimum_required(VERSION 3.13)

# Commmon function to add linker script and definitions for each target

string(COMPARE EQUAL ${CODESEC} S TEXT_IN_SRAM)
string(COMPARE EQUAL ${DATASEC} S DATA_IN_SRAM)

target_compile_definitions(
  ${TESTNAME}
  PRIVATE -DFRAM_WAIT=${WS}
  PRIVATE -DTEXT_IN_SRAM=${TEXT_IN_SRAM}
  PRIVATE -DDATA_IN_SRAM=${DATA_IN_SRAM}
  PRIVATE -DREPETITIONS=${REPETITIONS}
  )

target_link_libraries(${TESTNAME} PUBLIC support ${SUPPORT_LIBS})

target_compile_definitions(${TESTNAME} PUBLIC -DMSP430_ARCH)

# Add correct linker script depending on section allocations
target_link_options(${TESTNAME}
  PUBLIC -T${CMAKE_CURRENT_LIST_DIR}/../support/msp430fr5994-${CODESEC}${DATASEC}.ld)

set_target_properties(${TESTNAME} PROPERTIES SUFFIX ".elf")

# Emit map
add_custom_command(TARGET ${TESTNAME} POST_BUILD
  COMMAND ${TC-SIZE} -A -x "$<TARGET_FILE:${TESTNAME}>" > ${TESTNAME}.map
  COMMAND ${TC-OBJDUMP} -d "$<TARGET_FILE:${TESTNAME}>" > ${TESTNAME}.lst
  COMMAND ${TC-OBJCOPY} -O ihex "$<TARGET_FILE:${TESTNAME}>" ${TESTNAME}.hex
  )

# Add upload target
add_upload(${TESTNAME})
