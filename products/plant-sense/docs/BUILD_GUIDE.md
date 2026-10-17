# PlantSense Build Guide

Matches the product hero: **capsule head · teal neck ring · flat-face stem · 3 oval sensors · conical tip**.

## 1. Choose size

| Size | Pot | Bury | Total | STL |
|------|-----|------|-------|-----|
| S | 4–5″ | 95 mm | ~154 mm | `cad/stl/plant_sense_S.stl` |
| M | 6–7″ (hero) | 140 mm | ~199 mm | `cad/stl/plant_sense_M.stl` |
| L | 8–12″ | 195 mm | ~254 mm | `cad/stl/plant_sense_L.stl` |

Source: `cad/plant_sense_probe.scad` — set `SIZE = "S"|"M"|"L"`.

## 2. Print

- Dark charcoal PETG/ASA: stem + head + lid
- Teal PETG: accent ring (`PART="ring"` or `plant_sense_M_ring.stl`)
- 0.2 mm layer, 4 walls, 25% infill, stem upright

Or use `*_print.stl` print-plate files (all parts laid out).

## 3. Assemble

1. Seat three capacitive pads in the oval windows; epoxy edges; cure 24h.
2. Pull silicone wires up the hollow stem into the head cavity.
3. Slide teal ring onto the stem tenon.
4. Wire ESP32-C3 + TP4056 + battery; align USB-C with head cutout.
5. Press head onto tenon; glue/snap rear lid.
6. Flash firmware; calibrate dry/wet; pair app.

Full illustrated steps: website `/plant/#build`.
