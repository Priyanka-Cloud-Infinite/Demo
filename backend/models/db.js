var mongoose = require('mongoose');

var dbURL = 'mongodb://localhost:27017/shopping';

mongoose.connect(dbURL,{
    useNewUrlParser: true,
    useUnifiedTopology: true
});

mongoose.connection.on('connected',()=>{
    console.log('Mongoose default connection open to ' + dbURL);
});

mongoose.connection.on('error',(err)=>{
    console.log("mongoose connection error : "+err);
});

mongoose.connection.on('disconnected', function () {
    console.log('Mongoose default connection disconnected');
  });
  
  process.on('SIGINT', function() {
    mongoose.connection.close(function () {
      console.log('Mongoose default connection disconnected through app termination');
      process.exit(0);
    });
  });
  
  
  require('./schema');