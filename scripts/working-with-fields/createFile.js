'use strict';

const fs = require('fs');
const faker = require('faker');

const usernames = require('./usernames');
const commands = require('./commands');

let writeStream = fs.createWriteStream('logfile');

usernames.forEach((username, index, arr) => {
    writeStream.write(faker.date.future() + ':' + username + ':' + commands[index] + '\n');
});

// the finish event is emitted when all data has been flushed from the stream
writeStream.on('finish', () => {  
    console.log('Finished Writing to logfile');
});

// close the stream
writeStream.end();