const express = require('express');
const router = express();

const ctrl = require('../controllers/products');


router.get('/products',ctrl.products);

module.exports = router