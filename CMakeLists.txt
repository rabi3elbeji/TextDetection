cmake_minimum_required(VERSION 3.5)
project(TextDetection)

set(DEFAULT_BUILD_TYPE "Release")

add_subdirectory (targets/src)
enable_testing()
add_subdirectory (targets/test)