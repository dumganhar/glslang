# Copyright (C) 2020 The Khronos Group Inc.
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    Neither the name of The Khronos Group Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

if(ENABLE_GLSLANG_JS)

    add_library(glslang.js STATIC "glslang.js.cpp")
    target_link_libraries(glslang.js PRIVATE glslang SPIRV)

    # add_executable(glslang.js "glslang.js.cpp")
    # glslang_set_link_args(glslang.js)
    # target_link_libraries(glslang.js glslang SPIRV)

    # # Link library names that start with "-" are treated as link flags.
    # # "-Os" should be OK in MSVC; don't use /Os because CMake won't
    # # treat it as a link flag.
    # target_link_libraries(glslang.js "-Os")

    # if(EMSCRIPTEN)
    #     set_target_properties(glslang.js PROPERTIES
    #         OUTPUT_NAME "glslang"
    #         SUFFIX ".js")
    #     em_link_pre_js(glslang.js "${CMAKE_CURRENT_SOURCE_DIR}/glslang.pre.js")

    #     target_link_libraries(glslang.js "--llvm-lto 1")
    #     target_link_libraries(glslang.js "--closure 1")
    #     target_link_libraries(glslang.js "-s MODULARIZE=1")
    #     target_link_libraries(glslang.js "-s ALLOW_MEMORY_GROWTH=1")
    #     target_link_libraries(glslang.js "-s FILESYSTEM=0")

    #     target_link_libraries(glslang.js "-s DYNAMIC_EXECUTION=0")
    #     target_link_libraries(glslang.js "-s ERROR_ON_UNDEFINED_SYMBOLS=0")
    #     target_link_libraries(glslang.js "-s USE_ES6_IMPORT_META=0")
    #     target_link_libraries(glslang.js "-s EXPORT_ES6=1")
    #     target_link_libraries(glslang.js "-s NO_EXIT_RUNTIME=1")
    #     target_link_libraries(glslang.js "-s LLD_REPORT_UNDEFINED")
    #     target_link_libraries(glslang.js "-s MIN_SAFARI_VERSION=110000")

    #     # We use ccall in glslang.pre.js, so make sure it's exposed
    #     target_link_libraries(glslang.js "-s EXPORTED_RUNTIME_METHODS=ccall")

    #     if(ENABLE_EMSCRIPTEN_SINGLE_FILE)
    #         target_link_libraries(glslang.js "-s SINGLE_FILE=1")
    #     endif()

    #     if(ENABLE_EMSCRIPTEN_ENVIRONMENT_NODE)
    #         target_link_libraries(glslang.js "-s ENVIRONMENT=node -s BINARYEN_ASYNC_COMPILATION=0")
    #     else()
    #         target_link_libraries(glslang.js "-s ENVIRONMENT=web")
    #     endif()

    #     if(NOT ENABLE_EMSCRIPTEN_ENVIRONMENT_NODE)
    #         if (CMAKE_HOST_SYSTEM MATCHES "Windows.*")
    #             # There are several ways we could append one file to another on Windows, but unfortunately 'cat' is not one of them
    #             # (there is no 'cat' command in cmd). Also, since this will ultimately run in cmd and not pwsh, we need to ensure
    #             # Windows path separators are used.
    #             file(TO_NATIVE_PATH "${CMAKE_CURRENT_BINARY_DIR}/glslang.js" glslang_js_path)
    #             file(TO_NATIVE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/glslang.after.js" glslang_after_js_path)
    #             add_custom_command(TARGET glslang.js POST_BUILD
    #                 COMMAND type "${glslang_after_js_path}" >> "${glslang_js_path}")
    #         else()
    #             add_custom_command(TARGET glslang.js POST_BUILD
    #                 COMMAND cat ${CMAKE_CURRENT_SOURCE_DIR}/glslang.after.js >> ${CMAKE_CURRENT_BINARY_DIR}/glslang.js)
    #         endif()
    #     endif()
    # endif()
endif()
