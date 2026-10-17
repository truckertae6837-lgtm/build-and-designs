# ShopGuard Firmware

## PlatformIO
```
[env:esp32-c3]
platform = espressif32
board = esp32-c3-devkitm-1
framework = arduino
lib_deps = adafruit/Adafruit MPU6050
```

## States
IDLE → ARMED → COUNTDOWN → ALARM with CANCEL on button.

See `src/main.cpp`.
