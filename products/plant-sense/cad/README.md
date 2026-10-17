# PlantSense Probe CAD

Parametric OpenSCAD design matching the product hero photo:
**capsule head → teal neck ring → flat-face stem → 3 oval sensors → conical tip**.

## File

| File | Purpose |
|------|---------|
| `plant_sense_probe.scad` | **Use this** — hero-matched probe, sizes S/M/L |
| `stl/` | Pre-exported STLs ready to slice |
| `plant_sense_A_stake.scad` | Obsolete early sketch — do not print |

## Sizes (pick by pot depth)

| Size | Pot | Bury depth | Total height | STL |
|------|-----|------------|--------------|-----|
| **S** | 4–5″ / small houseplant | 95 mm | ~154 mm | `stl/plant_sense_S.stl` |
| **M** | 6–7″ / medium (hero) | 140 mm | ~199 mm | `stl/plant_sense_M.stl` |
| **L** | 8–12″ / large planter | 195 mm | ~254 mm | `stl/plant_sense_L.stl` |

Head (electronics housing) is **identical** across sizes. Only stem length and sensor spacing change.

## How to build the exact item

### Option A — download ready STLs (fastest)

1. Grab `plant_sense_S.stl` / `_M.stl` / `_L.stl` from `stl/` or `/downloads/plant-sense/` on the site.
2. For multi-color (dark body + teal ring), use the **print plate** files (`*_print.stl`) or separate parts:
   - `plant_sense_M_stem.stl` + `plant_sense_M_head.stl` + `plant_sense_M_lid.stl` → dark PETG/ASA
   - `plant_sense_M_ring.stl` → teal PETG
3. Slice: 0.2 mm layer, 4 walls, 25% gyroid, upright stem, supports off.
4. Glue ring onto stem tenon under the head; epoxy sensor pads into the three ovals; wire through hollow core into head; seat ESP32-C3 + battery; close lid.

### Option B — edit & re-export in OpenSCAD

```bash
# Assembled preview / single-body STL
openscad -D 'SIZE="M"' -D 'PART="assembled"' -o plant_sense_M.stl plant_sense_probe.scad

# Print plate (stem + head + lid + ring laid out)
openscad -D 'SIZE="L"' -D 'PART="print_plate"' -o plant_sense_L_print.stl plant_sense_probe.scad

# Single parts
openscad -D 'SIZE="S"' -D 'PART="stem"' -o stem_S.stl plant_sense_probe.scad
openscad -D 'PART="ring"' -o ring.stl plant_sense_probe.scad
```

`PART` values: `assembled` | `head` | `ring` | `stem` | `lid` | `print_plate`

## Print notes

- Material: PETG or ASA (soil + humidity). Avoid plain PLA outdoors.
- Orientation: stem upright on tip (or on flat side if your slicer prefers); head upright on base.
- Teal ring: print separately in teal filament, or pause-and-swap on a multi-material printer.
- After print: light sand flats, conformal-coat electronics, food-safe epoxy only on soil-facing pad edges.
