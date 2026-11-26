#!/usr/bin/env python3
"""Create a clearly marked placeholder for the user's real Hardware Simulator screenshot."""
from PIL import Image, ImageDraw

def create_hardware_test_screenshot(output_path="screenshot_tests.png"):
    img = Image.new("RGB", (1000, 600), "#f4f5f7")
    draw = ImageDraw.Draw(img)
    draw.rectangle((20, 20, 980, 580), outline="#7b8794", width=3)
    draw.text((55, 65), "ADD YOUR OFFICIAL HARDWARE SIMULATOR SCREENSHOT", fill="#111827")
    draw.text((55, 120), "CPU.tst | Memory.tst | ComputerAdd.tst | ComputerMax.tst | ComputerRect.tst", fill="#374151")
    draw.text((55, 180), "K = 51 | Roll No. 2501730451", fill="#374151")
    draw.text((55, 240), "This placeholder is not test evidence. Run the official .tst files and replace it.", fill="#b91c1c")
    img.save(output_path)
    print(f"Placeholder saved to: {output_path}")

if __name__ == "__main__":
    create_hardware_test_screenshot()
