#!/bin/bash

# Configuration file
CONFIG_FILE="javafx_path.txt"
JFX_PATH=""

if [ -f "$CONFIG_FILE" ]; then
    JFX_PATH=$(cat "$CONFIG_FILE")
fi

if [ -z "$JFX_PATH" ]; then
    echo "[Sort Pulse] Please enter the path to your JavaFX SDK directory (e.g. ~/javafx-sdk-25.0.1):"
    read -p "Path: " JFX_PATH
    echo "$JFX_PATH" > "$CONFIG_FILE"
fi

echo "[Sort Pulse] Using JavaFX SDK path: $JFX_PATH"

if [ ! -d "$JFX_PATH/lib" ]; then
    echo "[Sort Pulse] ERROR: 'lib' directory not found in '$JFX_PATH'"
    exit 1
fi

echo "[Sort Pulse] Compiling..."
javac --module-path "$JFX_PATH/lib" --add-modules javafx.controls,javafx.graphics app/ChromaCascadeApp.java
if [ $? -ne 0 ]; then
    echo "[Sort Pulse] Compilation failed."
    exit 1
fi

echo "[Sort Pulse] Running..."
java --module-path "$JFX_PATH/lib" --add-modules javafx.controls,javafx.graphics app.ChromaCascadeApp
