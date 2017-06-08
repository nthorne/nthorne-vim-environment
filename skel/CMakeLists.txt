cmake_minimum_required(VERSION 2.8)

project(hello)

file(GLOB_RECURSE SOURCES src/*.cpp)
add_executable(hello ${SOURCES})
