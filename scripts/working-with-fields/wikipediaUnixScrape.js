'use strict';

const request = require('request');
const cheerio = require('cheerio');

request('https://en.wikipedia.org/wiki/List_of_Unix_commands', (error, response, html) => {
    const $ = cheerio.load(html);
    const tableBody = $('tbody tr > td').text();
    console.log(tableBody);
});