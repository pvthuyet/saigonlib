@echo OFF
if "%1"=="clear" (
	rmdir build /S /Q
)
set BUILD=build
set X64=x64
set WIN32=win32
set OUTDIR=out_tmp
set fmt=fmt.lib
mkdir %BUILD%

:build64
echo.
echo ******* x64 buiding ...
mkdir %BUILD%/%X64%
cmake -S . -B ./%BUILD%/%X64% -DCMAKE_BUILD_TYPE=Release -Ax64
cmake --build ./%BUILD%/%X64% --clean-first --config Release
cmake --install ./%BUILD%/%X64% --prefix "%OUTDIR%/%X64%"

:build32
echo.
echo ******* win32 buiding ...
mkdir %BUILD%/%WIN32%
cmake -S . -B ./%BUILD%/%WIN32% -DCMAKE_BUILD_TYPE=Release -AWin32
cmake --build ./%BUILD%/%WIN32% --clean-first --config Release
cmake --install ./%BUILD%/%WIN32% --prefix "%OUTDIR%/%WIN32%"

:runcopy
xcopy %OUTDIR%\%X64%\lib\%fmt% lib\fmt64.lib* /Y /F
xcopy %OUTDIR%\%WIN32%\lib\%fmt% lib\fmt.lib* /Y /F
rmdir %OUTDIR% /S /Q

:End
echo done