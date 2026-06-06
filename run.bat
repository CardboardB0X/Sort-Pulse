@echo off
setlocal enabledelayedexpansion

:: Check for saved JavaFX path
set JFX_PATH=
if exist javafx_path.txt (
    set /p JFX_PATH=<javafx_path.txt
)

:: If not saved, check typical user download path
if "!JFX_PATH!"=="" (
    if exist "C:\Users\Japoy\Downloads\openjfx-25.0.1_windows-x64_bin-sdk\javafx-sdk-25.0.1" (
        set JFX_PATH=C:\Users\Japoy\Downloads\openjfx-25.0.1_windows-x64_bin-sdk\javafx-sdk-25.0.1
    )
)

:: If still empty, prompt the user
if "!JFX_PATH!"=="" (
    echo [Sort Pulse] JavaFX SDK path not detected.
    echo Please enter the absolute path to your JavaFX SDK directory (e.g. C:\javafx-sdk-25.0.1):
    set /p JFX_PATH="Path: "
    echo !JFX_PATH!>javafx_path.txt
)

echo [Sort Pulse] Using JavaFX SDK path: !JFX_PATH!

:: Verify lib folder exists
if not exist "!JFX_PATH!\lib" (
    echo [Sort Pulse] ERROR: "lib" folder not found under "!JFX_PATH!"
    echo Please make sure the path points to the main JavaFX SDK folder containing "lib" and "bin".
    pause
    exit /b 1
)

:: Compile
echo [Sort Pulse] Compiling...
javac --module-path "!JFX_PATH!\lib" --add-modules javafx.controls,javafx.graphics app/ChromaCascadeApp.java
if %errorlevel% neq 0 (
    echo [Sort Pulse] Compilation failed.
    pause
    exit /b %errorlevel%
)

:: Run
echo [Sort Pulse] Running...
java --module-path "!JFX_PATH!\lib" --add-modules javafx.controls,javafx.graphics app.ChromaCascadeApp
