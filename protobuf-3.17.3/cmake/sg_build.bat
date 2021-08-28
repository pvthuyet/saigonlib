@echo OFF
set BUILD=build_tmp
if "%1"=="clear" (
	rmdir %BUILD% /S /Q
)
set X64=x64
set WIN32=win32
set OUTDIR=../protobuf

mkdir %BUILD%

:build64
echo.
echo ******* x64 buiding ...
mkdir %BUILD%/%X64%
cmake -S . -B ./%BUILD%/%X64% -DCMAKE_BUILD_TYPE=Release -Ax64
cmake --build ./%BUILD%/%X64% --clean-first --config Release
cmake --install ./%BUILD%/%X64% --prefix "%OUTDIR%/%X64%" --config Release

:build64_debug
echo.
echo ******* x64 debug buiding ...
mkdir %BUILD%/%X64%_debug
cmake -S . -B ./%BUILD%/%X64%_debug -DCMAKE_BUILD_TYPE=Debug -Ax64
cmake --build ./%BUILD%/%X64%_debug --clean-first --config Debug
cmake --install ./%BUILD%/%X64%_debug --prefix "%OUTDIR%/%X64%_debug" --config Debug

:build32
echo.
echo ******* win32 buiding ...
mkdir %BUILD%/%WIN32%
cmake -S . -B ./%BUILD%/%WIN32% -DCMAKE_BUILD_TYPE=Release -AWin32
cmake --build ./%BUILD%/%WIN32% --clean-first --config Release
cmake --install ./%BUILD%/%WIN32% --prefix "%OUTDIR%/%WIN32%" --config Release

echo.
echo ******* win32 debug buiding ...
mkdir %BUILD%/%WIN32%_debug
cmake -S . -B ./%BUILD%/%WIN32%_debug -DCMAKE_BUILD_TYPE=Debug -AWin32
cmake --build ./%BUILD%/%WIN32%_debug --clean-first --config Debug
cmake --install ./%BUILD%/%WIN32%_debug --prefix "%OUTDIR%/%WIN32%_debug" --config Debug

rem :Copy
rem set INCLUDEDIR=..\protobuf\include
rem xcopy %OUTDIR%\%X64%\include\* %INCLUDEDIR% /Y /F /S /I
rem 
rem set LIBDIR=..\protobuf\lib\%X64%
rem set BINDIR=..\protobuf\bin\%X64%
rem xcopy %OUTDIR%\%X64%\lib\*.lib %LIBDIR%\* /Y /F
rem xcopy %OUTDIR%\%X64%\bin\*.exe %BINDIR%\* /Y /F
rem xcopy %OUTDIR%\%X64%_debug\lib\*.lib %LIBDIR%\* /Y /F
rem 
rem REM win32
rem set LIBDIR=..\protobuf\lib\%WIN32%
rem set BINDIR=..\protobuf\bin\%WIN32%
rem xcopy %OUTDIR%\%WIN32%\lib\*.lib %LIBDIR%\* /Y /F
rem xcopy %OUTDIR%\%WIN32%\bin\*.exe %BINDIR%\* /Y /F
rem xcopy %OUTDIR%\%WIN32%_debug\lib\*.lib %LIBDIR%\* /Y /F

:End
echo done