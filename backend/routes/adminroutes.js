const express = require('express');
const router = express();

const ctrl =  require('../controllers/products.js');

router.get('/',(req,res)=>{
    res.json("welcome to control panel");
})
router.get('/products',ctrl.products);

module.exports = router