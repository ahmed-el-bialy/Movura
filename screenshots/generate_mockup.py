#!/usr/bin/env python3
"""
Movura Screenshot Mockup Generator
===================================
Creates a promotional image with 9 screenshots placed inside phone mockup
frames, arranged in 2 rows (5 on top, 4 on bottom), centered.

Usage:
    python3 generate_mockup.py

Output:
    movura_mockup.png  (in the same directory)

Requirements:
    pip install Pillow
"""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageFilter
import math

# ──────────────────────────────────────────────────────────────────────
# Configuration
# ──────────────────────────────────────────────────────────────────────

SCREENSHOTS_DIR = Path(__file__).parent

# The 9 best screenshots representing the app (ordered for visual flow)
SCREENSHOT_FILES = [
    "splash_screen.png",       # 1. Splash
    "login.png",               # 2. Login
    "home_p1.png",             # 3. Home
    "home_p2.png",             # 4. Home (Top Rated)
    "search_results.png",      # 5. Search Results
    "movie_details_p1.png",    # 6. Movie Details
    "movie_details_p3.png",    # 7. Movie Details (Trailers/Images)
    "tv_details_p1.png",       # 8. TV Details
    "trailer_player_v.png",    # 9. Trailer Player
]

# Phone frame dimensions
PHONE_SCREEN_W = 360          # Width of the screen area inside the phone
PHONE_SCREEN_H = 780          # Height of the screen area inside the phone
PHONE_BEZEL = 14              # Bezel thickness around the screen
PHONE_CORNER_RADIUS = 36      # Corner radius of the phone body
SCREEN_CORNER_RADIUS = 24     # Corner radius of the screen
NOTCH_WIDTH = 100             # Width of the top notch/dynamic island
NOTCH_HEIGHT = 24             # Height of the top notch
NOTCH_RADIUS = 12             # Corner radius of the notch

# Layout
ROWS = [5, 4]                 # Number of phones per row
PHONE_SPACING_X = 50          # Horizontal spacing between phones
PHONE_SPACING_Y = 60          # Vertical spacing between rows
PADDING_X = 80                # Left/right padding of the canvas
PADDING_Y = 80                # Top/bottom padding of the canvas

# Colors (matching Movura's dark theme)
BG_COLOR_TOP = (8, 10, 18)          # Deep dark navy (top of gradient)
BG_COLOR_BOTTOM = (14, 18, 32)      # Slightly lighter navy (bottom)
PHONE_BODY_COLOR = (20, 24, 40)     # Dark phone frame
PHONE_BORDER_COLOR = (50, 55, 75)   # Subtle border highlight
SCREEN_BG_COLOR = (0, 0, 0)         # Black screen fallback
NEON_CYAN = (0, 209, 255)           # Movura's neon accent
SHADOW_COLOR = (0, 0, 0, 120)       # Drop shadow


# ──────────────────────────────────────────────────────────────────────
# Helper Functions
# ──────────────────────────────────────────────────────────────────────

def create_rounded_rectangle_mask(size, radius):
    """Create an anti-aliased rounded rectangle mask."""
    # Create at 2x for anti-aliasing, then downscale
    scale = 2
    w, h = size[0] * scale, size[1] * scale
    r = radius * scale
    mask = Image.new("L", (w, h), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle([0, 0, w - 1, h - 1], radius=r, fill=255)
    return mask.resize(size, Image.LANCZOS)


def create_phone_frame(screenshot_path):
    """
    Creates a phone mockup with the given screenshot placed inside.
    Returns an RGBA image of the phone with transparent background.
    """
    # Calculate full phone dimensions (screen + bezel)
    phone_w = PHONE_SCREEN_W + 2 * PHONE_BEZEL
    phone_h = PHONE_SCREEN_H + 2 * PHONE_BEZEL

    # Create the phone body
    phone = Image.new("RGBA", (phone_w, phone_h), (0, 0, 0, 0))

    # --- Draw phone body (rounded rectangle with border) ---
    body_mask = create_rounded_rectangle_mask((phone_w, phone_h), PHONE_CORNER_RADIUS)

    # Outer body (border color)
    body_border = Image.new("RGBA", (phone_w, phone_h), (*PHONE_BORDER_COLOR, 255))
    phone.paste(body_border, (0, 0), body_mask)

    # Inner body (slightly inset)
    inner_inset = 2  # Border thickness
    inner_w = phone_w - 2 * inner_inset
    inner_h = phone_h - 2 * inner_inset
    inner_mask = create_rounded_rectangle_mask(
        (inner_w, inner_h), PHONE_CORNER_RADIUS - inner_inset
    )
    inner_body = Image.new("RGBA", (inner_w, inner_h), (*PHONE_BODY_COLOR, 255))
    phone.paste(inner_body, (inner_inset, inner_inset), inner_mask)

    # --- Place the screenshot ---
    try:
        screenshot = Image.open(screenshot_path).convert("RGBA")
    except Exception as e:
        print(f"  ⚠️  Could not open {screenshot_path}: {e}")
        screenshot = Image.new("RGBA", (PHONE_SCREEN_W, PHONE_SCREEN_H), (*SCREEN_BG_COLOR, 255))

    # Resize screenshot to fit the screen area (crop to fill)
    sc_w, sc_h = screenshot.size
    target_ratio = PHONE_SCREEN_W / PHONE_SCREEN_H
    current_ratio = sc_w / sc_h

    if current_ratio > target_ratio:
        # Too wide — crop sides
        new_w = int(sc_h * target_ratio)
        left = (sc_w - new_w) // 2
        screenshot = screenshot.crop((left, 0, left + new_w, sc_h))
    elif current_ratio < target_ratio:
        # Too tall — crop bottom
        new_h = int(sc_w / target_ratio)
        screenshot = screenshot.crop((0, 0, sc_w, new_h))

    screenshot = screenshot.resize(
        (PHONE_SCREEN_W, PHONE_SCREEN_H), Image.LANCZOS
    )

    # Apply rounded corners to the screenshot
    screen_mask = create_rounded_rectangle_mask(
        (PHONE_SCREEN_W, PHONE_SCREEN_H), SCREEN_CORNER_RADIUS
    )
    # Composite screenshot with rounded mask
    screen_with_corners = Image.new("RGBA", (PHONE_SCREEN_W, PHONE_SCREEN_H), (0, 0, 0, 0))
    screen_with_corners.paste(screenshot, (0, 0), screen_mask)

    phone.paste(screen_with_corners, (PHONE_BEZEL, PHONE_BEZEL), screen_with_corners)

    # --- Draw the notch / dynamic island ---
    draw = ImageDraw.Draw(phone)
    notch_x = (phone_w - NOTCH_WIDTH) // 2
    notch_y = PHONE_BEZEL - 2
    draw.rounded_rectangle(
        [notch_x, notch_y, notch_x + NOTCH_WIDTH, notch_y + NOTCH_HEIGHT],
        radius=NOTCH_RADIUS,
        fill=(*PHONE_BODY_COLOR, 255),
    )

    return phone


def add_drop_shadow(image, offset=(6, 8), blur_radius=20, shadow_color=SHADOW_COLOR):
    """Add a subtle drop shadow behind the phone."""
    # Create shadow
    shadow = Image.new("RGBA", image.size, (0, 0, 0, 0))
    shadow_mask = image.split()[3]  # Use alpha channel as mask
    shadow_layer = Image.new("RGBA", image.size, shadow_color)
    shadow.paste(shadow_layer, (0, 0), shadow_mask)
    shadow = shadow.filter(ImageFilter.GaussianBlur(blur_radius))

    # Combine: shadow below, image on top
    result_w = image.size[0] + abs(offset[0]) + blur_radius * 2
    result_h = image.size[1] + abs(offset[1]) + blur_radius * 2
    result = Image.new("RGBA", (result_w, result_h), (0, 0, 0, 0))

    shadow_x = blur_radius + max(0, offset[0])
    shadow_y = blur_radius + max(0, offset[1])
    result.paste(shadow, (shadow_x, shadow_y), shadow)

    img_x = blur_radius + max(0, -offset[0])
    img_y = blur_radius + max(0, -offset[1])
    result.paste(image, (img_x, img_y), image)

    return result, (img_x, img_y)


def create_gradient_background(width, height, color_top, color_bottom):
    """Create a vertical gradient background."""
    bg = Image.new("RGB", (width, height))
    for y in range(height):
        ratio = y / height
        r = int(color_top[0] + (color_bottom[0] - color_top[0]) * ratio)
        g = int(color_top[1] + (color_bottom[1] - color_top[1]) * ratio)
        b = int(color_top[2] + (color_bottom[2] - color_top[2]) * ratio)
        for x in range(width):
            bg.putpixel((x, y), (r, g, b))
    return bg


def create_gradient_background_fast(width, height, color_top, color_bottom):
    """Create a vertical gradient background (fast version using line drawing)."""
    bg = Image.new("RGB", (width, height), color_top)
    draw = ImageDraw.Draw(bg)
    for y in range(height):
        ratio = y / height
        r = int(color_top[0] + (color_bottom[0] - color_top[0]) * ratio)
        g = int(color_top[1] + (color_bottom[1] - color_top[1]) * ratio)
        b = int(color_top[2] + (color_bottom[2] - color_top[2]) * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    return bg


def add_neon_glow(canvas, phones_data):
    """Add subtle neon cyan glow effects to make the image pop."""
    glow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(glow)

    # Add a subtle glow strip at the top
    for i in range(60):
        alpha = int(12 * (1 - i / 60))
        draw.line(
            [(0, i), (canvas.size[0], i)],
            fill=(*NEON_CYAN, alpha),
        )

    # Add a subtle glow strip at the bottom
    h = canvas.size[1]
    for i in range(60):
        alpha = int(8 * (1 - i / 60))
        draw.line(
            [(0, h - 1 - i), (canvas.size[0], h - 1 - i)],
            fill=(*NEON_CYAN, alpha),
        )

    canvas.paste(Image.alpha_composite(canvas.convert("RGBA"), glow))


# ──────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────

def main():
    print("🎬 Movura Mockup Generator")
    print("=" * 50)

    # Step 1: Generate phone frames
    print("\n📱 Creating phone mockups...")
    phones = []
    for i, filename in enumerate(SCREENSHOT_FILES):
        path = SCREENSHOTS_DIR / filename
        print(f"  [{i+1}/{len(SCREENSHOT_FILES)}] {filename}")
        phone = create_phone_frame(path)
        phones.append(phone)

    # Step 2: Add drop shadows to each phone
    print("\n🌑 Adding drop shadows...")
    phone_images = []
    phone_offsets = []
    for phone in phones:
        shadowed, offset = add_drop_shadow(phone)
        phone_images.append(shadowed)
        phone_offsets.append(offset)

    # Step 3: Calculate canvas dimensions
    phone_w_with_shadow = phone_images[0].size[0]
    phone_h_with_shadow = phone_images[0].size[1]

    max_cols = max(ROWS)
    canvas_w = 2 * PADDING_X + max_cols * phone_w_with_shadow + (max_cols - 1) * PHONE_SPACING_X
    canvas_h = (
        2 * PADDING_Y
        + len(ROWS) * phone_h_with_shadow
        + (len(ROWS) - 1) * PHONE_SPACING_Y
    )

    print(f"\n📐 Canvas size: {canvas_w} × {canvas_h}")

    # Step 4: Create background
    print("🎨 Creating gradient background...")
    canvas = create_gradient_background_fast(canvas_w, canvas_h, BG_COLOR_TOP, BG_COLOR_BOTTOM)
    canvas = canvas.convert("RGBA")

    # Step 5: Place phones on canvas
    print("📍 Placing phones on canvas...")
    idx = 0
    phones_positions = []
    for row_idx, cols in enumerate(ROWS):
        # Center this row
        row_width = cols * phone_w_with_shadow + (cols - 1) * PHONE_SPACING_X
        start_x = (canvas_w - row_width) // 2
        y = PADDING_Y + row_idx * (phone_h_with_shadow + PHONE_SPACING_Y)

        for col in range(cols):
            if idx >= len(phone_images):
                break
            x = start_x + col * (phone_w_with_shadow + PHONE_SPACING_X)
            canvas.paste(phone_images[idx], (x, y), phone_images[idx])
            phones_positions.append((x, y))
            idx += 1

    # Step 6: Add neon glow effects
    print("✨ Adding neon glow effects...")
    add_neon_glow(canvas, phones_positions)

    # Step 7: Save
    output_path = SCREENSHOTS_DIR / "movura_mockup.png"
    canvas = canvas.convert("RGB")
    canvas.save(str(output_path), "PNG", optimize=True)
    print(f"\n✅ Mockup saved to: {output_path}")
    print(f"   Size: {canvas.size[0]} × {canvas.size[1]} px")
    print(f"   File: {output_path.stat().st_size / 1024 / 1024:.1f} MB")


if __name__ == "__main__":
    main()
