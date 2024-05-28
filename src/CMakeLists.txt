# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(open_files_plugin_library VERSION 0.0.1 LANGUAGES C)

add_library(open_files_plugin SHARED
  "open_files_plugin.c"
)

set_target_properties(open_files_plugin PROPERTIES
  PUBLIC_HEADER open_files_plugin.h
  OUTPUT_NAME "open_files_plugin"
)

target_compile_definitions(open_files_plugin PUBLIC DART_SHARED_LIB)
