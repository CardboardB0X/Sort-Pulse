@echo off
setlocal enabledelayedexpansion

rem Check for saved JavaFX path
set JFX_PATH=
if exist javafx_path.txt (
    set /p JFX_PATH=<javafx_path.txt
)
if "%JFX_PATH%"=="" (
    if exist "C:\Users\Japoy\Downloads\openjfx-25.0.1_windows-x64_bin-sdk\javafx-sdk-25.0.1" (
        set JFX_PATH=C:\Users\Japoy\Downloads\openjfx-25.0.1_windows-x64_bin-sdk\javafx-sdk-25.0.1
    )
)
if "%JFX_PATH%"=="" (
    echo [Sort Pulse] JavaFX SDK path not detected.
    echo Please enter the absolute path to your JavaFX SDK directory containing 'lib' folder:
    set /p JFX_PATH="Path: "
)
set JFX_PATH=%JFX_PATH:"=%
echo %JFX_PATH%>javafx_path.txt

echo ===================================================
echo [Sort Pulse Packaging] Using JavaFX SDK: %JFX_PATH%
echo ===================================================

rem Cleanup previous builds
echo Cleaning up old directories...
if exist out rmdir /s /q out
if exist jar_input rmdir /s /q jar_input
if exist dist rmdir /s /q dist

rem Create build folders
mkdir out
mkdir jar_input

rem Compile classes
echo Compiling source code...
javac -d out --module-path "%JFX_PATH%\lib" --add-modules javafx.controls,javafx.graphics app/ChromaCascadeApp.java
if %errorlevel% neq 0 (
    echo Compilation failed.
    pause
    exit /b %errorlevel%
)

rem Copy font resource to output package layout
echo Copying font resource...
mkdir out\app
copy app\PressStart2P-Regular.ttf out\app\

rem Package into self-contained JAR
echo Packaging classes and resources into sort-pulse.jar...
jar --create --file jar_input/sort-pulse.jar --main-class app.ChromaCascadeApp -C out .
if %errorlevel% neq 0 (
    echo JAR creation failed.
    pause
    exit /b %errorlevel%
)

rem Build standalone portable app image (folder containing SortPulse.exe + JRE)
echo Building portable directory (app-image)...
jpackage --type app-image --input jar_input --dest dist --name "SortPulse" --main-jar sort-pulse.jar --module-path "%JFX_PATH%\lib" --add-modules javafx.controls,javafx.graphics
if %errorlevel% neq 0 (
    echo Portable app-image build failed.
    pause
    exit /b %errorlevel%
)

echo Copying JavaFX native DLLs to portable runtime...
copy "%JFX_PATH%\bin\*.dll" "dist\SortPulse\runtime\bin\"
if %errorlevel% neq 0 (
    echo Copying JavaFX native DLLs failed.
    pause
    exit /b %errorlevel%
)

rem Build native Windows setup installer (.exe wizard)
echo Building Windows installer (.exe setup)...
jpackage --type exe --input jar_input --dest dist --name "SortPulseInstaller" --main-jar sort-pulse.jar --module-path "%JFX_PATH%\lib" --add-modules javafx.controls,javafx.graphics --win-dir-chooser --win-shortcut
if %errorlevel% neq 0 (
    echo Windows installer build failed.
    pause
    exit /b %errorlevel%
)

echo ===================================================
echo [Sort Pulse Packaging] Standalone builds completed successfully!
echo Look in the "dist" folder for:
echo   1. "SortPulse" folder (portable app, click SortPulse.exe to play)
echo   2. "SortPulseInstaller.exe" (Windows installer wizard)
echo ===================================================
pause
