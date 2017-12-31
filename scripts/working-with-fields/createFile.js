'use strict';

const fs = require('fs');
const faker = require('faker');

let writeStream = fs.createWriteStream('logfile');

for (let i = 0; i < 500; i++) {
    writeStream.write(faker.date.future() + ':' + faker.internet.userName() + ':' + faker.lorem.slug() + '\n');
}


// the finish event is emitted when all data has been flushed from the stream
writeStream.on('finish', () => {  
    console.log('Finished Writing to logfile');
});

// close the stream
writeStream.end()