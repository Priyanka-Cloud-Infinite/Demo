var mongoose = require('mongoose');


var products = [
    {
        name:'abc',
        price:200
    },
    {
        name:'qwe',
        price:500
    },
    {
        name:'abc',
        price:200
    },
    {
        name:'abc',
        price:200
    },
    {
        name:'abc',
        price:200
    },
    {
        name:'abc',
        price:200
    }
]

module.exports.products = (req,res)  =>{
    res.json(products);
}