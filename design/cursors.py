"""Lindle's cursor theme, generated without any tools beyond Pillow.

Draws the arrow and the text cursor (white with a dark outline and a soft
shadow, in the style of the Lindle mark) at several sizes and writes them in
the Xcursor format directly. Everything else falls back to Breeze cursors.

Outputs: system_files/usr/share/icons/LindleCursors/
"""

import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CURSOR_DIR = ROOT / "system_files" / "usr" / "share" / "icons" / "LindleCursors"

SIZES = [24, 32, 48, 64, 96]  # nominal sizes; Plasma picks by scale and cursor size setting
SUPER = 8

# Names that all show the same cursor.
ARROW_NAMES = ["left_ptr", "default", "arrow", "top_left_arrow", "left_arrow"]
TEXT_NAMES = ["text", "xterm", "ibeam"]


def _canvas(size):
    from PIL import Image

    return Image.new("L", (size * SUPER, size * SUPER), 0)


def _arrow_mask(size):
    from PIL import ImageDraw

    m = _canvas(size)
    k = size * SUPER / 32
    pts = [(2.5, 2), (2.5, 23.5), (8, 18.5), (11.6, 27), (15.4, 25.4), (11.9, 17.2), (19.5, 17.2)]
    ImageDraw.Draw(m).polygon([(x * k, y * k) for x, y in pts], fill=255)
    return m, (2.5 * size / 32, 2 * size / 32)


def _text_mask(size):
    from PIL import ImageDraw

    m = _canvas(size)
    k = size * SUPER / 32
    d = ImageDraw.Draw(m)
    w = 2.2 * k
    d.line([(16 * k, 6 * k), (16 * k, 26 * k)], fill=255, width=round(w))
    d.line([(12 * k, 6 * k), (20 * k, 6 * k)], fill=255, width=round(w))
    d.line([(12 * k, 26 * k), (20 * k, 26 * k)], fill=255, width=round(w))
    return m, (16 * size / 32, 16 * size / 32)


def render(mask, size):
    """White shape, dark outline, soft shadow -> RGBA at the nominal size."""
    from PIL import Image, ImageChops, ImageFilter

    outline_px = max(3, round(1.6 * size / 32 * SUPER)) | 1
    outer = mask.filter(ImageFilter.MaxFilter(outline_px))
    shadow = ImageChops.offset(outer, round(0.8 * size / 32 * SUPER), round(1.6 * size / 32 * SUPER))
    shadow = shadow.filter(ImageFilter.GaussianBlur(1.4 * size / 32 * SUPER))

    big = Image.new("RGBA", mask.size, (0, 0, 0, 0))
    big.paste(Image.new("RGBA", mask.size, (0, 0, 0, 90)), (0, 0), shadow)
    big.paste(Image.new("RGBA", mask.size, (24, 25, 31, 255)), (0, 0), outer)
    big.paste(Image.new("RGBA", mask.size, (255, 255, 255, 255)), (0, 0), mask)
    return big.resize((size, size), Image.LANCZOS)


def xcursor(images):
    """Xcursor file from [(nominal_size, RGBA image, (xhot, yhot))]."""
    header = 16
    toc = 12 * len(images)
    chunks = []
    offset = header + toc
    entries = []
    for nominal, img, (xh, yh) in images:
        w, h = img.size
        pixels = bytearray()
        for r, g, b, a in img.getdata():
            # Premultiplied ARGB, little endian.
            pr, pg, pb = ((c * a + 127) // 255 for c in (r, g, b))
            pixels += struct.pack("<BBBB", pb, pg, pr, a)
        chunk = struct.pack("<IIIIIIIII", 36, 0xFFFD0002, nominal, 1, w, h, round(xh), round(yh), 50) + bytes(pixels)
        entries.append(struct.pack("<III", 0xFFFD0002, nominal, offset))
        offset += len(chunk)
        chunks.append(chunk)
    return b"Xcur" + struct.pack("<III", header, 0x10000, len(images)) + b"".join(entries) + b"".join(chunks)


def write_cursors():
    try:
        import PIL  # noqa: F401
    except ImportError:
        print("Pillow not installed, skipping cursors")
        return
    out = CURSOR_DIR / "cursors"
    out.mkdir(parents=True, exist_ok=True)
    for names, maker in ((ARROW_NAMES, _arrow_mask), (TEXT_NAMES, _text_mask)):
        images = []
        for size in SIZES:
            mask, hot = maker(size)
            images.append((size, render(mask, size), hot))
        data = xcursor(images)
        (out / names[0]).write_bytes(data)
        for alias in names[1:]:
            link = out / alias
            if link.is_symlink() or link.exists():
                link.unlink()
            link.symlink_to(names[0])
    (CURSOR_DIR / "index.theme").write_text(
        "[Icon Theme]\nName=Lindle\nComment=Lindle's pointer: white with a dark outline\nInherits=breeze_cursors\n"
    )
    print(f"wrote {CURSOR_DIR.relative_to(ROOT)}")
