# Inspired from cmake.bbclass
# CMake system name must be something like "Linux".
# This is important for cross-compiling.
set( CMAKE_SYSTEM_NAME Linux )
set( CMAKE_SYSROOT "/opt/sdk/tmp/sysroots/qemuarm64" )
set( CMAKE_SYSROOT_NATIVE "/opt/sdk/tmp/sysroots/x86_64" )
set( ENV{PATH}   "/opt/sdk/tmp/sysroots/x86_64/usr/bin/aarch64-poky-linux:/opt/sdk/tmp/sysroots/x86_64/usr/bin:/opt/sdk/tmp/sysroots/x86_64/usr/sbin:/opt/sdk/tmp/sysroots/x86_64/bin:/opt/sdk/tmp/sysroots/x86_64/sbin:/opt/sdk/tmp/sysroots/x86_64/usr/bin/../x86_64-pokysdk-linux/bin:/opt/sdk/tmp/sysroots/x86_64/:/usr/bin" )

# Variables at buildtime:
#  HOST_CC_ARCH= -mcpu=cortex-a72.cortex-a53 -march=armv8-a+crc -fstack-protector-strong  -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security
#  TARGET_CC_ARCH= -mcpu=cortex-a72.cortex-a53 -march=armv8-a+crc -fstack-protector-strong  -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security

set( CMAKE_SYSTEM_PROCESSOR aarch64 )
set( CMAKE_C_COMPILER aarch64-poky-linux-gcc )
set( CMAKE_CXX_COMPILER aarch64-poky-linux-g++ )
set( CMAKE_ASM_COMPILER aarch64-poky-linux-gcc )

set ( CPU_FLAGS "-mcpu=cortex-a57 -march=armv8-a+crc --sysroot=/opt/sdk/tmp/sysroots/qemuarm64" ) 
foreach ( lang C CXX ASM )
  set ( CMAKE_${lang}_FLAGS "${CPU_FLAGS}"
        CACHE STRING "Flags used by the ${lang} compiler during all build types.")
endforeach ( lang )

# only search in the paths provided so cmake doesnt pick
# up libraries and tools from the native build machine
set( CMAKE_FIND_ROOT_PATH /opt/sdk/tmp/sysroots/qemuarm64 /opt/sdk/tmp/sysroots/x86_64 )
set( CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )

#
# FW specific part
#
foreach ( lang C CXX ASM )
  # Don't use any other default options
  foreach ( type DEBUG MINSIZEREL RELEASE RELWITHDEBINFO )
    string ( TOLOWER "${type}" type_low )
    set ( CMAKE_${lang}_FLAGS_${type} "" CACHE STRING "Flags used by the compiler during ${type_low} builds" )
  endforeach ( type )
endforeach ( lang )

# We need to set the rpath to the correct directory as cmake does not provide any
# directory as rpath by default
set( CMAKE_INSTALL_RPATH "" )

# add for non /usr/lib libdir, e.g. /usr/lib64
set( CMAKE_LIBRARY_PATH /opt/sdk/tmp/sysroots/qemuarm64/usr/lib )

# target dependent emulator
set ( CMAKE_CROSSCOMPILING_EMULATOR ${CMAKE_SYSROOT_NATIVE}/usr/bin/qemu-aarch64 -L ${CMAKE_SYSROOT} )

