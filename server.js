const express = require('express');
const compression = require('compression');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(compression());
app.use(express.static(path.join(__dirname, 'public'), { maxAge: '1h' }));
app.use('/products', express.static(path.join(__dirname, 'products'), { maxAge: '1h' }));

app.get('/health', (_req, res) => res.json({ ok: true, products: ['plant-sense', 'ladder-level', 'shopguard'] }));

app.get('*', (_req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => console.log(`Build & Designs listening on ${PORT}`));
