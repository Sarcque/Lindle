"""Lindle's Plasma style (desktop theme), generated from design/tokens.json.

Plasma draws panels, menus, popups and tooltips from 9-patch SVGs: nine cells
(four corners, four edges, a center), "hint-*" rectangles for margins, "mask-*"
cells for the blurred area behind them and "shadow-*" cells for the shadow.
Breeze's versions have 6 px corners. Lindle's use the radii from the tokens,
a hairline border and a softer, wider shadow. Everything else (buttons,
scrollbars, icons...) falls back to Breeze.

Layout of every file, same ids as Breeze's:
    main cells at (0, 0), mask cells to their right, shadow cells below.

Outputs: system_files/usr/share/plasma/desktoptheme/Lindle/
"""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
THEME_DIR = ROOT / "system_files" / "usr" / "share" / "plasma" / "desktoptheme" / "Lindle"

TILE = 32  # length of the stretching edge cells

# name -> (corner radius token, content margin)
FILES = {
    "widgets/panel-background.svg": ("large", 6),
    "dialogs/background.svg": ("large", 8),
    "widgets/tooltip.svg": ("medium", 6),
}

# variant folder -> (fill opacity, has shadow)
VARIANTS = {
    "": (0.86, True),
    "translucent": (0.74, True),
    "opaque": (1.0, False),
    "solid": (1.0, True),
}

SHADOW = 18          # how far the shadow reaches beyond the edge
SHADOW_ALPHA = 0.30  # darkest point, at the edge

STYLE = """  <defs>
    <style type="text/css" id="current-color-scheme">
      .ColorScheme-Text { color:#232629; }
      .ColorScheme-Background { color:#eff0f1; }
    </style>
"""


def fmt(v):
    return f"{v:g}"


def corner_fill(name, r):
    """Quarter disk filling a corner cell of size r x r."""
    paths = {
        "topleft": f"M0,{r} A{r},{r} 0 0 1 {r},0 V{r} Z",
        "topright": f"M0,0 A{r},{r} 0 0 1 {r},{r} H0 Z",
        "bottomleft": f"M0,0 H{r} V{r} A{r},{r} 0 0 1 0,0 Z",
        "bottomright": f"M{r},0 A{r},{r} 0 0 1 0,{r} V0 Z",
    }
    return paths[name]


def corner_border(name, r):
    """Hairline along the outer arc of a corner cell."""
    h = r - 0.5
    paths = {
        "topleft": f"M0.5,{r} V{r} A{h},{h} 0 0 1 {r},0.5",
        "topright": f"M0,0.5 A{h},{h} 0 0 1 {r - 0.5},{r}",
        "bottomleft": f"M0.5,0 V0 A{h},{h} 0 0 0 {r},{r - 0.5}",
        "bottomright": f"M{r - 0.5},0 A{h},{h} 0 0 1 0,{r - 0.5}",
    }
    return paths[name]


def border_attrs():
    return 'class="ColorScheme-Text" fill="none" stroke="currentColor" stroke-width="1" stroke-opacity="0.16"'


def cell(cid, x, y, w, h, body):
    return f'  <g id="{cid}" transform="translate({fmt(x)},{fmt(y)})">\n{body}  </g>\n'


def main_cells(r, opacity, prefix_ids=("",)):
    """The nine visible cells of the background."""
    out = []
    fill = f'class="ColorScheme-Background" fill="currentColor" opacity="{fmt(opacity)}"'
    t = TILE
    # (id, x, y, w, h, fill element, border element)
    edges = {
        "top": (r, 0, t, r, f'<rect width="{t}" height="{r}" {fill}/>', f'<path d="M0,0.5 H{t}" {border_attrs()}/>'),
        "bottom": (r, r + t, t, r, f'<rect width="{t}" height="{r}" {fill}/>', f'<path d="M0,{r - 0.5} H{t}" {border_attrs()}/>'),
        "left": (0, r, r, t, f'<rect width="{r}" height="{t}" {fill}/>', f'<path d="M0.5,0 V{t}" {border_attrs()}/>'),
        "right": (r + t, r, r, t, f'<rect width="{r}" height="{t}" {fill}/>', f'<path d="M{r - 0.5},0 V{t}" {border_attrs()}/>'),
        "center": (r, r, t, t, f'<rect width="{t}" height="{t}" {fill}/>', ""),
    }
    for cid, (x, y, w, h, f, b) in edges.items():
        out.append(cell(cid, x, y, w, h, f"    {f}\n" + (f"    {b}\n" if b else "")))
    corners = {"topleft": (0, 0), "topright": (r + t, 0), "bottomleft": (0, r + t), "bottomright": (r + t, r + t)}
    for cid, (x, y) in corners.items():
        out.append(cell(cid, x, y, r, r,
                        f'    <path d="{corner_fill(cid, r)}" {fill}/>\n'
                        f'    <path d="{corner_border(cid, r)}" {border_attrs()}/>\n'))
    return "".join(out)


def mask_cells(r, ox):
    """Where the blur applies: the same shape, any color."""
    t = TILE
    f = 'fill="#000"'
    out = []
    rects = {
        "mask-top": (r, 0, t, r), "mask-bottom": (r, r + t, t, r),
        "mask-left": (0, r, r, t), "mask-right": (r + t, r, r, t), "mask-center": (r, r, t, t),
    }
    for cid, (x, y, w, h) in rects.items():
        out.append(f'  <rect id="{cid}" x="{fmt(ox + x)}" y="{fmt(y)}" width="{w}" height="{h}" {f}/>\n')
    corners = {"mask-topleft": ("topleft", 0, 0), "mask-topright": ("topright", r + t, 0),
               "mask-bottomleft": ("bottomleft", 0, r + t), "mask-bottomright": ("bottomright", r + t, r + t)}
    for cid, (name, x, y) in corners.items():
        out.append(f'  <path id="{cid}" transform="translate({fmt(ox + x)},{fmt(y)})" d="{corner_fill(name, r)}" {f}/>\n')
    return "".join(out)


def shadow_cells(r, oy):
    """Soft shadow around the shape, with a hole where the panel itself is."""
    s = SHADOW
    sr = s + r
    t = TILE
    a = SHADOW_ALPHA
    # Falloff curve from the edge (darkest) outward, as (position 0..1, opacity).
    curve = [(0.0, 1.0), (0.2, 0.62), (0.45, 0.28), (0.7, 0.09), (1.0, 0.0)]

    defs = []
    body = []

    def stops_xml(stops):
        return "".join(
            f'<stop offset="{fmt(round(f, 4))}" stop-color="#000" stop-opacity="{fmt(round(o, 4))}"/>' for f, o in stops
        )

    def linear(gid, vertical, outer_first):
        """Across an edge cell: s px of falloff next to the panel, r px of hole under it.

        outer_first: the shadow side is at offset 0 (top, left cells) or at the far end.
        """
        if outer_first:
            stops = [((s - pos * s) / sr, op * a) for pos, op in reversed(curve)]
            stops += [(s / sr + 0.0005, 0.0), (1.0, 0.0)]
        else:
            stops = [(0.0, 0.0), (r / sr - 0.0005, 0.0)]
            stops += [(r / sr + pos * s / sr, op * a) for pos, op in curve]
        x2, y2 = ("0", "1") if vertical else ("1", "0")
        defs.append(f'    <linearGradient id="{gid}" x1="0" y1="0" x2="{x2}" y2="{y2}">{stops_xml(stops)}</linearGradient>\n')

    linear("g-top", True, True)
    linear("g-bottom", True, False)
    linear("g-left", False, True)
    linear("g-right", False, False)

    def radial(gid, cx, cy):
        """Around a corner: hole inside the panel's arc (radius r), falloff outside it."""
        stops = [(0.0, 0.0), (r / sr - 0.0005, 0.0)]
        stops += [(r / sr + pos * s / sr, op * a) for pos, op in curve]
        defs.append(
            f'    <radialGradient id="{gid}" gradientUnits="userSpaceOnUse" cx="{fmt(cx)}" cy="{fmt(cy)}" r="{fmt(sr)}">'
            f"{stops_xml(stops)}</radialGradient>\n"
        )

    # Cell origins inside the shadow block (which starts at y = oy).
    cells = {
        "shadow-topleft": (0, 0, sr, sr, "g-tl", (sr, sr)),
        "shadow-top": (sr, 0, t, sr, "g-top", None),
        "shadow-topright": (sr + t, 0, sr, sr, "g-tr", (0, sr)),
        "shadow-left": (0, sr, sr, t, "g-left", None),
        "shadow-center": (sr, sr, t, t, None, None),
        "shadow-right": (sr + t, sr, sr, t, "g-right", None),
        "shadow-bottomleft": (0, sr + t, sr, sr, "g-bl", (sr, 0)),
        "shadow-bottom": (sr, sr + t, t, sr, "g-bottom", None),
        "shadow-bottomright": (sr + t, sr + t, sr, sr, "g-br", (0, 0)),
    }
    for cid, (x, y, w, h, grad, center) in cells.items():
        if grad is None:
            body.append(f'  <rect id="{cid}" x="{x}" y="{oy + y}" width="{w}" height="{h}" fill="#000" fill-opacity="0.001"/>\n')
            continue
        if center is not None:
            radial(grad, x + center[0], oy + y + center[1])
            body.append(f'  <rect id="{cid}" x="{x}" y="{oy + y}" width="{w}" height="{h}" fill="url(#{grad})"/>\n')
        else:
            # Linear gradients are in the cell's own bounding box; the id sits on the rect.
            body.append(f'  <rect id="{cid}" x="{x}" y="{oy + y}" width="{w}" height="{h}" fill="url(#{grad})"/>\n')

    # Shadow margins and insets: the shadow reaches s px past the edge.
    hints = ""
    hy = oy + 2 * sr + t + 6
    for i, name in enumerate(("top", "bottom", "left", "right")):
        horizontal = name in ("top", "bottom")
        w, h = (2, s) if horizontal else (s, 2)
        for kind, fillc, base in (("margin", "#ff00ff", 0), ("inset", "#00ff00", 12)):
            hints += f'  <rect id="shadow-hint-{name}-{kind}" x="{base + i * 24}" y="{hy}" width="{w}" height="{h}" fill="{fillc}"/>\n'
    return "".join(defs), "".join(body) + hints, 2 * sr + t


def hint_rects(r, margin):
    """Content margins (magenta) and insets (green), as in Breeze."""
    t = TILE
    out = []
    m = margin
    y_mid = r + t / 2
    x_mid = r + t / 2
    specs = {
        "hint-top-margin": (x_mid, r, 4, m),
        "hint-bottom-margin": (x_mid, r + t - m + r, 4, m),
        "hint-left-margin": (0, y_mid, m, 4),
        "hint-right-margin": (2 * r + t - m, y_mid, m, 4),
    }
    for hid, (x, y, w, h) in specs.items():
        out.append(f'  <rect id="{hid}" x="{fmt(x)}" y="{fmt(y)}" width="{fmt(w)}" height="{fmt(h)}" fill="#ff00ff"/>\n')
    for side, (x, y, w, h) in {
        "top": (x_mid, r, 4, 1e-8), "bottom": (x_mid, 2 * r + t, 4, 1e-8),
        "left": (0, y_mid, 1e-8, 4), "right": (2 * r + t, y_mid, 1e-8, 4),
    }.items():
        out.append(f'  <rect id="hint-{side}-inset" x="{fmt(x)}" y="{fmt(y)}" width="{fmt(w)}" height="{fmt(h)}" fill="#00ff00"/>\n')
    return "".join(out)


def thick_cells(ox, oy):
    """Breeze's "thick" panel mode: a flat rectangle with fixed margins."""
    out = [f'  <rect id="thick-center" x="{ox}" y="{oy}" width="32" height="32" class="ColorScheme-Background" fill="currentColor"/>\n']
    out.append(f'  <rect id="thick-hint-top-margin" x="{ox + 12}" y="{oy}" width="4" height="8" fill="#800080"/>\n')
    out.append(f'  <rect id="thick-hint-bottom-margin" x="{ox + 12}" y="{oy + 24}" width="4" height="8" fill="#800080"/>\n')
    out.append(f'  <rect id="thick-hint-left-margin" x="{ox}" y="{oy + 12}" width="8" height="4" fill="#800080"/>\n')
    out.append(f'  <rect id="thick-hint-right-margin" x="{ox + 24}" y="{oy + 12}" width="8" height="4" fill="#800080"/>\n')
    return "".join(out)


def build_svg(r, margin, opacity, with_shadow, thick):
    t = TILE
    main = 2 * r + t
    mask_x = main + 8
    parts = [
        '<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n',
        "<!-- Generated by design/plasma.py from design/tokens.json. Do not edit by hand. -->\n",
    ]
    # No "hint-tile-center": a flat center is stretched, so semi-transparent tiles never leave seams.
    body = main_cells(r, opacity)
    body += hint_rects(r, margin)
    body += mask_cells(r, mask_x)
    height = main
    width = mask_x + main
    defs_extra = ""
    if with_shadow:
        oy = main + 8
        defs_extra, shadow_body, block = shadow_cells(r, oy)
        body += shadow_body
        height = oy + block + 40
        width = max(width, block + 8)
    if thick:
        body += thick_cells(mask_x + 0, height if not with_shadow else height)
        height += 40
    parts.append(
        f'<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="{width}" height="{height}" viewBox="0 0 {width} {height}">\n'
    )
    parts.append(STYLE + defs_extra + "  </defs>\n")
    parts.append(body)
    parts.append("</svg>\n")
    return "".join(parts)


def write_plasma(tokens):
    import json

    radius = tokens["radius"]
    for rel, (token, margin) in FILES.items():
        r = radius[token]
        for variant, (opacity, shadow) in VARIANTS.items():
            path = THEME_DIR / variant / rel if variant else THEME_DIR / rel
            path.parent.mkdir(parents=True, exist_ok=True)
            thick = rel.endswith("panel-background.svg")
            path.write_text(build_svg(r, margin, opacity, shadow, thick))

    metadata = {
        "KPlugin": {
            "Authors": [{"Name": "Lindle Contributors"}],
            "Description": "Lindle's Plasma style: rounded, softly lit panels and menus",
            "EnabledByDefault": True,
            "Id": "Lindle",
            "License": "Apache-2.0",
            "Name": "Lindle",
            "Version": tokens["version"],
            "Website": "https://github.com/sarcque/lindle",
        },
        "X-Plasma-API": "5.0",
    }
    (THEME_DIR / "metadata.json").write_text(json.dumps(metadata, indent=4) + "\n")
    # Enables Breeze's panel opacity options (adaptive, translucent, opaque).
    (THEME_DIR / "plasmarc").write_text("[AdaptiveTransparency]\nenabled=true\n")
    count = sum(1 for _ in THEME_DIR.rglob("*.svg"))
    print(f"wrote {THEME_DIR.relative_to(ROOT)} ({count} svg files)")
