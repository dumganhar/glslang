@echo off

set VCVARS="C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat"
set CMAKE="C:\Program Files\CMake\bin\CMake.exe"
if [%1] == [] (
    @REM set ARCH=win32
    set ARCH=x64
) else (
    set ARCH=%1
)

set BUILD_DIR=build-windows-%ARCH%

if exist %BUILD_DIR%\output\ (
    rmdir /q /s %BUILD_DIR%\output
)

%CMAKE% -B %BUILD_DIR% ^
    -A%ARCH% ^
    -DENABLE_HLSL=OFF ^
    -DENABLE_SPVREMAPPER=OFF ^
    -DSKIP_GLSLANG_INSTALL=ON ^
    -DSPIRV_SKIP_EXECUTABLES=ON

@REM The debug version of SPIRV-Tools-opt is just too cumbersome to be carried around
node build-utils.js --enable-debug-opt %BUILD_DIR%\External\spirv-tools\source\opt\SPIRV-Tools-opt.vcxproj

call %VCVARS% x64
call devenv %BUILD_DIR%\glslang.sln /Build Debug
call devenv %BUILD_DIR%\glslang.sln /Build Release

mkdir %BUILD_DIR%\output

for /r %BUILD_DIR% %%x in (*.lib) do xcopy %%x %BUILD_DIR%\output\ /y

del %BUILD_DIR%\output\*SPIRV-Tools-link*
del %BUILD_DIR%\output\*SPIRV-Tools-reduce*
del %BUILD_DIR%\output\*SPIRV-Tools-shared*
