# Install script for directory: D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files/llama_cpp")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/Debug/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/Release/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/MinSizeRel/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/RelWithDebInfo/ggml.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/Debug/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/Release/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/MinSizeRel/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/RelWithDebInfo/ggml.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-alloc.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-backend.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-blas.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-cann.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-cuda.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-kompute.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-metal.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-rpc.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-sycl.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-vulkan.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/Debug/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/Release/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/MinSizeRel/ggml.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/GitHubRepo/LANEING/Cleanser/build/vendor/llama.cpp/ggml/src/RelWithDebInfo/ggml.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/Debug/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/Release/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/MinSizeRel/ggml.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/GitHubRepo/LANEING/Cleanser/build/bin/RelWithDebInfo/ggml.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-alloc.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-backend.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-blas.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-cann.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-cuda.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-kompute.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-metal.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-rpc.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-sycl.h"
    "D:/GitHubRepo/LANEING/Cleanser/Activities/Intelligence/llama-cpp-python/vendor/llama.cpp/ggml/include/ggml-vulkan.h"
    )
endif()

