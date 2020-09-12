# CMake Ada - Ada language support for CMake
# Copyright (C) 2014 offa
#
# This file is part of CMake Ada.
#
# CMake Ada is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CMake Ada is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CMake Ada. If not, see <http://www.gnu.org/licenses/>.

if(UNIX)
    set(CMAKE_ADA_OUTPUT_EXTENSION .o)
else()
    set(CMAKE_ADA_OUTPUT_EXTENSION .o)
endif()
# set replacing extension
# otherwise compiler produce error
# gnat1: incorrect object file name
SET(CMAKE_ADA_OUTPUT_EXTENSION_REPLACE 1)

set(CMAKE_ADA_SOURCE_FILE_EXTENSIONS adb ads)


if(CMAKE_ADA_COMPILER_ID)
    include(Compiler/${CMAKE_ADA_COMPILER_ID}-ADA OPTIONAL)
endif()

set(CMAKE_ADA_FLAGS_INIT "$ENV{ADAFLAGS} ${CMAKE_ADA_FLAGS_INIT}")

cmake_initialize_per_config_variable(CMAKE_ADA_FLAGS "Flags used by the ADA compiler")

if(CMAKE_ADA_STANDARD_LIBRARIES_INIT)
    set(CMAKE_ADA_STANDARD_LIBRARIES "${CMAKE_ADA_STANDARD_LIBRARIES_INIT}" CACHE STRING "Libraries linked by defalut with all Ada applications.")
    mark_as_advanced(CMAKE_ADA_STANDARD_LIBRARIES)
endif()

include(CMakeCommonLanguageInclude)

# Removes objects after each target build
set(__CLEAN "rm -f *${CMAKE_ADA_OUTPUT_EXTENSION}")

set(CMAKE_ADA_COMPILE_OBJECT "<CMAKE_ADA_COMPILER> <FLAGS> <CMAKE_ADA_LINK_FLAGS> -c <SOURCE>")
set(CMAKE_ADA_LINK_EXECUTABLE "" ${__CLEAN})
set(CMAKE_ADA_CREATE_STATIC_LIBRARY "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> *${CMAKE_ADA_OUTPUT_EXTENSION}" "ranlib *.a" ${__CLEAN})

set(CMAKE_ADA_INFORMATION_LOADED 1)
