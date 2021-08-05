@echo OFF
set BUILD=build_tmp
if "%1"=="clear" (
	rmdir %BUILD% /S /Q
)
set X64=x64
set WIN32=win32
set OUTDIR=out_tmp
set NAME_ST=sgutils
set NAME_ST_D=sgutils

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

:runcopy
set TARGET_NAME_ST=sgutils
set TARGET_NAME_ST_D=sgutilsd

REM x64
set LIBDIR=lib\%X64%
xcopy %OUTDIR%\%X64%\lib\%NAME_ST%.lib %LIBDIR%\%TARGET_NAME_ST%.lib* /Y /F

xcopy %OUTDIR%\%X64%_debug\lib\%NAME_ST_D%.lib %LIBDIR%\%TARGET_NAME_ST_D%.lib* /Y /F

REM win32
set LIBDIR=lib\%WIN32%
xcopy %OUTDIR%\%WIN32%\lib\%NAME_ST%.lib %LIBDIR%\%TARGET_NAME_ST%.lib* /Y /F

xcopy %OUTDIR%\%WIN32%_debug\lib\%NAME_ST_D%.lib %LIBDIR%\%TARGET_NAME_ST_D%.lib* /Y /F

REM rmdir %OUTDIR% /S /Q

:End
echo done