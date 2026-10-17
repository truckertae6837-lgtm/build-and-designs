# Build & Designs

Focused product kits:

1. **PlantSense** — 3-zone soil moisture + plant photo guidance app
2. **LadderLevel** — interlocking uneven-ground ladder wedges
3. **ShopGuard** — solo-worker fall / no-motion alarm (SOS + cancel)

## Run locally
```bash
npm install
npm start
# open http://localhost:3000
```

## Structure
- `public/` — website
- `products/*/cad` — OpenSCAD
- `products/*/patent` — inventor disclosure packs
- `products/*/bom` — materials
- `products/*/firmware` or `software` — code stubs

## Deploy
Railway: set start command `npm start`, root directory repo root.
