# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/d/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/d/GitHubRepo/LANEING/Cleanser/build

# Include any dependencies generated for this target.
include vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/compiler_depend.make

# Include the progress variables for this target.
include vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/progress.make

# Include the compile flags for this target's objects.
include vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/flags.make

# Object files for target llava_shared
llava_shared_OBJECTS =

# External object files for target llava_shared
llava_shared_EXTERNAL_OBJECTS = \
"/mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava/CMakeFiles/llava.dir/llava.cpp.o" \
"/mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava/CMakeFiles/llava.dir/clip.cpp.o"

vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/examples/llava/CMakeFiles/llava.dir/llava.cpp.o
vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/examples/llava/CMakeFiles/llava.dir/clip.cpp.o
vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/build.make
vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/src/libllama.so
vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/ggml/src/libggml.so
vendor/llama.cpp/examples/llava/libllava.so: vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/d/GitHubRepo/LANEING/Cleanser/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Linking CXX shared library libllava.so"
	cd /mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/llava_shared.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/build: vendor/llama.cpp/examples/llava/libllava.so
.PHONY : vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/build

vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/clean:
	cd /mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava && $(CMAKE_COMMAND) -P CMakeFiles/llava_shared.dir/cmake_clean.cmake
.PHONY : vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/clean

vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/depend:
	cd /mnt/d/GitHubRepo/LANEING/Cleanser/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/d/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python /mnt/d/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/examples/llava /mnt/d/GitHubRepo/LANEING/Cleanser/build /mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava /mnt/d/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : vendor/llama.cpp/examples/llava/CMakeFiles/llava_shared.dir/depend
