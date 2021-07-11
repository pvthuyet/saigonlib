@echo OFF
set BUILD=build_tmp
if "%1"=="clear" (
	rmdir %BUILD% /S /Q
)
set X64=x64
set WIN32=win32
set OUTDIR=out_tmp
set NAME_ST=zmqpp-static
set NAME_DY=zmqpp

set NAME_ST_D=zmqpp-static
set NAME_DY_D=zmqpp

set zmq_inc="..\libzmq-4.3.4\include"
set zmq_inc_dir="..\libzmq-4.3.4\include"
set zmq_lib_dir="..\libzmq-4.3.4\lib"

mkdir %BUILD%

:build64
echo.
echo ******* x64 buiding ...
mkdir %BUILD%/%X64%
cmake -S . -B ./%BUILD%/%X64% -DCMAKE_BUILD_TYPE=Release -Ax64 -DZEROMQ_INCLUDE=%zmq_inc% -DZEROMQ_INCLUDE_DIR=%zmq_inc_dir% -DZEROMQ_LIB_DIR=%zmq_lib_dir%/%X64% -DZEROMQ_LIBRARY_SHARED=libzmq -DZEROMQ_LIBRARY_STATIC=libzmq_static -DZQPP_BUILD_SHARED=1 -DZQPP_BUILD_STATIC=1
cmake --build ./%BUILD%/%X64% --clean-first --config Release
cmake --install ./%BUILD%/%X64% --prefix "%OUTDIR%/%X64%" --config Release

:build64_debug
echo.
echo ******* x64 debug buiding ...
mkdir %BUILD%/%X64%_debug
cmake -S . -B ./%BUILD%/%X64%_debug -DCMAKE_BUILD_TYPE=Debug -Ax64 -DZEROMQ_INCLUDE=%zmq_inc% -DZEROMQ_INCLUDE_DIR=%zmq_inc_dir% -DZEROMQ_LIB_DIR=%zmq_lib_dir%/%X64% -DZEROMQ_LIBRARY_SHARED=libzmqd -DZEROMQ_LIBRARY_STATIC=libzmq_staticd -DZQPP_BUILD_SHARED=1 -DZQPP_BUILD_STATIC=1
cmake --build ./%BUILD%/%X64%_debug --clean-first --config Debug
cmake --install ./%BUILD%/%X64%_debug --prefix "%OUTDIR%/%X64%_debug" --config Debug

:build32
echo.
echo ******* win32 buiding ...
mkdir %BUILD%/%WIN32%
cmake -S . -B ./%BUILD%/%WIN32% -DCMAKE_BUILD_TYPE=Release -AWin32 -DZEROMQ_INCLUDE=%zmq_inc% -DZEROMQ_INCLUDE_DIR=%zmq_inc_dir% -DZEROMQ_LIB_DIR=%zmq_lib_dir%/%WIN32% -DZEROMQ_LIBRARY_SHARED=libzmq -DZEROMQ_LIBRARY_STATIC=libzmq_static -DZQPP_BUILD_SHARED=1 -DZQPP_BUILD_STATIC=1
cmake --build ./%BUILD%/%WIN32% --clean-first --config Release
cmake --install ./%BUILD%/%WIN32% --prefix "%OUTDIR%/%WIN32%" --config Release

echo.
echo ******* win32 debug buiding ...
mkdir %BUILD%/%WIN32%_debug
cmake -S . -B ./%BUILD%/%WIN32%_debug -DCMAKE_BUILD_TYPE=Debug -AWin32 -DZEROMQ_INCLUDE=%zmq_inc% -DZEROMQ_INCLUDE_DIR=%zmq_inc_dir% -DZEROMQ_LIB_DIR=%zmq_lib_dir%/%WIN32% -DZEROMQ_LIBRARY_SHARED=libzmqd -DZEROMQ_LIBRARY_STATIC=libzmq_staticd -DZQPP_BUILD_SHARED=1 -DZQPP_BUILD_STATIC=1
cmake --build ./%BUILD%/%WIN32%_debug --clean-first --config Debug
cmake --install ./%BUILD%/%WIN32%_debug --prefix "%OUTDIR%/%WIN32%_debug" --config Debug

:runcopy
set TARGET_NAME_ST=libzmq-static
set TARGET_NAME_ST_D=libzmq-staticd
set TARGET_NAME_DY=libzmq
set TARGET_NAME_DY_D=libzmqd

REM x64
set LIBDIR=lib\%X64%
xcopy %OUTDIR%\%X64%\lib\%NAME_ST%.lib %LIBDIR%\%TARGET_NAME_ST%.lib* /Y /F
xcopy %OUTDIR%\%X64%\lib\%NAME_DY%.lib %LIBDIR%\%TARGET_NAME_DY%.lib* /Y /F
xcopy %OUTDIR%\%X64%\bin\%NAME_DY%.dll %LIBDIR%\%TARGET_NAME_DY%.dll* /Y /F

xcopy %OUTDIR%\%X64%_debug\lib\%NAME_ST_D%.lib %LIBDIR%\%TARGET_NAME_ST_D%.lib* /Y /F
xcopy %OUTDIR%\%X64%_debug\lib\%NAME_DY_D%.lib %LIBDIR%\%TARGET_NAME_DY_D%.lib* /Y /F
xcopy %OUTDIR%\%X64%_debug\bin\%NAME_DY_D%.dll %LIBDIR%\%TARGET_NAME_DY_D%.dll* /Y /F
xcopy %OUTDIR%\%X64%_debug\bin\%NAME_DY_D%.pdb %LIBDIR%\%TARGET_NAME_DY_D%.pdb* /Y /F

REM win32
set LIBDIR=lib\%WIN32%
xcopy %OUTDIR%\%WIN32%\lib\%NAME_ST%.lib %LIBDIR%\%TARGET_NAME_ST%.lib* /Y /F
xcopy %OUTDIR%\%WIN32%\lib\%NAME_DY%.lib %LIBDIR%\%TARGET_NAME_DY%.lib* /Y /F
xcopy %OUTDIR%\%WIN32%\bin\%NAME_DY%.dll %LIBDIR%\%TARGET_NAME_DY%.dll* /Y /F

xcopy %OUTDIR%\%WIN32%_debug\lib\%NAME_ST_D%.lib %LIBDIR%\%TARGET_NAME_ST_D%.lib* /Y /F
xcopy %OUTDIR%\%WIN32%_debug\lib\%NAME_DY_D%.lib %LIBDIR%\%TARGET_NAME_DY_D%.lib* /Y /F
xcopy %OUTDIR%\%WIN32%_debug\bin\%NAME_DY_D%.dll %LIBDIR%\%TARGET_NAME_DY_D%.dll* /Y /F
xcopy %OUTDIR%\%WIN32%_debug\bin\%NAME_DY_D%.pdb %LIBDIR%\%TARGET_NAME_DY_D%.pdb* /Y /F

REM rmdir %OUTDIR% /S /Q

:End
echo done