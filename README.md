# Sort Pulse 🎮

**Sort Pulse** is a fast-paced, timed arcade puzzle game where you race against the clock to sort colored number blocks using real sorting algorithms — **Selection Sort**, **Quick Sort**, and **Merge Sort**. Each mode challenges you to think like the algorithm and manually drive every step.

---

## 🖼️ Features

- 🕹️ Three playable sorting algorithm modes
- ⏱️ Countdown timer with time bonuses for completing waves
- 🎯 Step-by-step visual guides (manual slideshow) before each game
- 🔊 Retro synthetic sound effects (generated at runtime — no audio files needed)
- 📊 Comparison operator display (`<` / `>`) between cursor and pivot in Quick Sort
- 💚 Green-lock feedback on correctly placed blocks
- 🔴 Flash-border feedback on wrong moves
- ⌨️ Full keyboard controls

---

## 🧰 Prerequisites

| Requirement | Version |
|---|---|
| Java Development Kit (JDK) | **21 or higher** (tested on Java 25) |
| OpenJFX (JavaFX SDK) | **21 or higher** (tested on 25.0.1) |

### Download Links
- **JDK**: https://adoptium.net/ or https://jdk.java.net/
- **OpenJFX SDK**: https://gluonhq.com/products/javafx/ — download the **SDK** (not jmods) for your OS

---

## 📁 Project Structure

```
Sort-Pulse/
├── app/
│   └── ChromaCascadeApp.java   ← Full source (single-file architecture)
└── README.md
```

---

## 🚀 How to Run

### Step 1 — Clone the Repository

```bash
git clone https://github.com/CardboardB0X/Sort-Pulse.git
cd Sort-Pulse
```

### Step 2 — Download and Extract JavaFX SDK

Download the **JavaFX SDK** for your operating system from:  
👉 https://gluonhq.com/products/javafx/

Extract it somewhere accessible, e.g.:

| OS | Example path |
|---|---|
| Windows | `C:\javafx-sdk-25.0.1` |
| macOS / Linux | `~/javafx-sdk-25.0.1` |

### Step 3 — Compile

**Windows (PowerShell / CMD):**
```powershell
javac --module-path "C:\javafx-sdk-25.0.1\lib" ^
      --add-modules javafx.controls,javafx.graphics ^
      app/ChromaCascadeApp.java
```

**macOS / Linux (Bash):**
```bash
javac --module-path ~/javafx-sdk-25.0.1/lib \
      --add-modules javafx.controls,javafx.graphics \
      app/ChromaCascadeApp.java
```

> Replace the path after `--module-path` with wherever you extracted your JavaFX SDK.

### Step 4 — Run

**Windows:**
```powershell
java --module-path "C:\javafx-sdk-25.0.1\lib" ^
     --add-modules javafx.controls,javafx.graphics ^
     app.ChromaCascadeApp
```

**macOS / Linux:**
```bash
java --module-path ~/javafx-sdk-25.0.1/lib \
     --add-modules javafx.controls,javafx.graphics \
     app.ChromaCascadeApp
```

The game launches in **fullscreen** automatically.

---

## ⌨️ Controls

| Key | Action |
|---|---|
| `D` / `→` | Move cursor right |
| `A` / `←` | Move cursor left |
| `Enter` | Confirm / place selected block |
| `ESC` | Return to main menu |

### Visual Guide Controls
| Key | Action |
|---|---|
| `D` / `→` / `NEXT` button | Next slide |
| `A` / `←` / `PREV` button | Previous slide |

---

## 🎮 Game Modes

### Selection Sort
Find the **minimum** unsorted element and move it to its correct position. The highlighted cursor scans the array; press `Enter` on the smallest element.

### Quick Sort
A **pivot** block (rightmost of the active range) is shown with an orange badge. Scan each element:
- If `element ≤ pivot` → press `Enter` to shift it left
- After all scans, press `Enter` to place the pivot in its final slot

A `<` / `>` comparison indicator floats above the blocks to show the current comparison.

### Merge Sort
Two pre-sorted **subarrays** (A and B) appear on the upper level. A merged output area sits below. Compare the **HEAD** of each subarray and press `Enter` on the smaller one to merge it into the output.

Time bonuses:
- Selection Sort: **+10s** per wave
- Quick Sort: **+10s** per wave
- Merge Sort: **+30s** per wave

---

## 🛠️ Troubleshooting

**`Error: JavaFX runtime components are missing`**  
→ Make sure `--module-path` points to the correct JavaFX SDK `lib` folder and that `--add-modules` is included.

**`package app does not exist` / class not found**  
→ Ensure you compiled first (`javac ...`) and are running from the **project root** directory (not inside `app/`).

**Native access warning on Java 21+**  
→ This is a harmless JavaFX warning. Add `--enable-native-access=javafx.graphics` to silence it:
```bash
java --enable-native-access=javafx.graphics \
     --module-path ~/javafx-sdk-25.0.1/lib \
     --add-modules javafx.controls,javafx.graphics \
     app.ChromaCascadeApp
```

---

## 📄 License

This project is for educational purposes. Feel free to fork and modify.
