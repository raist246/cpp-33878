cmake_minimum_required(VERSION 3.26)
project(test)

set(CMAKE_CXX_STANDARD 17)

set (INC_UAPI_DIR "/opt/sdk/tmp/sysroots/qemuarm64/usr/include")

add_executable(test main.cpp)
include_directories(${INC_UAPI_DIR})
include_directories(${INC_UAPI_DIR}/misc)
include_directories(${INC_UAPI_DIR}/xen)
include_directories(${INC_UAPI_DIR}/sys)
include_directories(${INC_UAPI_DIR}/video)
include_directories(${INC_UAPI_DIR}/rpc)
include_directories(${INC_UAPI_DIR}/net)
include_directories(${INC_UAPI_DIR}/mtd)
include_directories(${INC_UAPI_DIR}/netrom)
include_directories(${INC_UAPI_DIR}/nfs)
