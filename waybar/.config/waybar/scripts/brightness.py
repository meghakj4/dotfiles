#!/usr/bin/env python3
import sys
import os
import json
import subprocess

BACKLIGHT_PATH = "/sys/class/backlight/amdgpu_bl1"

def get_brightness():
    try:
        with open(os.path.join(BACKLIGHT_PATH, "brightness")) as f:
            curr = int(f.read().strip())
        with open(os.path.join(BACKLIGHT_PATH, "max_brightness")) as f:
            max_b = int(f.read().strip())
        pct = round((curr / max_b) * 100)
        return curr, max_b, pct
    except Exception:
        return 0, 100, 0

def set_brightness(new_val, max_b):
    new_val = max(1000, min(max_b, new_val))
    cmd = [
        "busctl", "call", "org.freedesktop.login1",
        "/org/freedesktop/login1/session/auto",
        "org.freedesktop.login1.Session", "SetBrightness",
        "ssu", "backlight", "amdgpu_bl1", str(new_val)
    ]
    subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def main():
    curr, max_b, pct = get_brightness()
    step = int(max_b * 0.05)

    if len(sys.argv) > 1:
        action = sys.argv[1]
        if action == "up":
            set_brightness(curr + step, max_b)
        elif action == "down":
            set_brightness(curr - step, max_b)
        elif action == "toggle":
            target = max_b if pct < 50 else int(max_b * 0.3)
            set_brightness(target, max_b)
        sys.exit(0)

    icons = ["󰃞", "󰃟", "󰃠"]
    icon = icons[0] if pct < 35 else (icons[1] if pct < 75 else icons[2])
    data = {
        "text": f"{icon} {pct}%",
        "tooltip": f"Screen Brightness: {pct}%\nScroll: Adjust Brightness\nClick: Toggle High/Low",
        "percentage": pct,
        "class": "brightness"
    }
    print(json.dumps(data))

if __name__ == "__main__":
    main()
