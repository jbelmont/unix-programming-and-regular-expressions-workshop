## Unix Programming and Regular Expressions Workshop - Building Command line applications

## Sections:

* [Command Line Applications](#command-line-applications)
* [Node CommandLine Application](#node-commandline-application)
* [Golang CommandLine Application](#golang-commandline-application)
* [Quick summary](#quick-summary)
* [Link to Golang Workshop](#link-to-golang-workshop)
* [Bread Crumb Navigation](#bread-crumb-navigation)

## Command Line Applications

Building command line applications can be done using any turing complete programming language of your choice.

The 2 Programming Languages we will look at here:

* Node.js
* Golang

## Node CommandLine Application

First off we will not use `commander.js` or any third party libraries to make a generic cli application. 

We will use plain node.js

```javascript
'use strict';

const process = require('process');
const fs = require('fs');

const lib = require('../lib');
const utf8 = require('../constants').utf8;

const args = process.argv.slice(2);

const tsvOrCsv = args.some(arg => {
  return arg === '--tsv-file' || arg === '--csv-file';
});

if (!tsvOrCsv) {
  lib.UsageMessage();
  process.exit(1);
}

const csvIndex = args.findIndex(arg => arg === '--csv-file');
let csv, tsv;
if (csvIndex > -1) {
  csv  = args.slice(csvIndex);
}

const tsvIndex = args.findIndex(arg => arg === '--tsv-file');
if (tsvIndex > -1) {
  tsv = args.slice(tsvIndex);
}
if (csv) {
  const csvPath = csv[1];
  const fileContents = [];
  fileReader(csvPath, function(err, data) {
    if (err) throw err;
    const [
      language,
      frequency
    ] = data.split(',');
    console.log(language);
    console.log(frequency);
  });
} else if (tsv) {
  const tsvPath = tsv[1];
  console.log(tsvPath);
} else {
  lib.UsageMessage();
  process.exit(1);
}

function fileReader(filePath, cb) {
  fs.readFile(`${__dirname}/../${filePath}`, utf8, function(err, data) {
    if (err) return cb(err);
    cb(null, data);
  });
}
```

Here is a snippet of code I used for node.js on one hand you can parse commandline flags relatively easy.

In node.js you can just use `process.argv` and parse out the flags that were passed in via the commmandline

## Golang CommandLine Application

Golang already has features built into the standard library that make building command line applications simple.

```go
package main

import (
	"bufio"
	"encoding/csv"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"os"
)

func convertToJSON(f *os.File, isTSVFile bool) {
	rows := make([]map[string]string, 0)
	var columns = []string{"language", "frequency"}
	// Create a new reader.
	csvReader := csv.NewReader(bufio.NewReader(f))
	csvReader.TrimLeadingSpace = true
	if isTSVFile {
		csvReader.Comma = '\t' // Use tab-delimited instead of comma
	}
	for {
		record, err := csvReader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println(err)
		}
		row := make(map[string]string)
		for i, n := range columns {
			row[n] = record[i]
		}
		rows = append(rows, row)
	}
	data, err := json.MarshalIndent(&rows, "", "  ")
	if err != nil {
		fmt.Println(err)
	}
	// print the reformatted struct as JSON
	fmt.Printf("%s\n", data)
}

func main() {
	csvPtr := flag.String("csv-file", "", "CSV File to parse. (Required)")
	tsvPtr := flag.String("tsv-file", "", "TSV File to parse. (Required)")
	flag.Parse()

	if *csvPtr == "" && *tsvPtr == "" {
		flag.PrintDefaults()
		os.Exit(1)
	} else if *csvPtr != "" {
		f, err := os.Open(*csvPtr)
		if err != nil {
			fmt.Println(err)
		}
		defer f.Close()
		convertToJSON(f, false)
	} else {
		f, err := os.Open(*tsvPtr)
		if err != nil {
			fmt.Println(err)
		}
		defer f.Close()
		convertToJSON(f, true)
	}
}
```

Notice here that I just used the `flag` builtin library and it does the job of parsing command line flags.

Also dealing with asychronous code in `Golang` is much easier than using `Node.js`. 

There are many design patterns built into Golang that make writing commandline applications a joy to work with.

## Quick summary

You can write cli apps use either `Node.js` or `Golang` but consider writing a command line application in Golang. 

## Link to Golang Workshop

I wrote a [Golang workshop](https://github.com/jbelmont/golang-workshop) which you can check out if you aren't familiar with Go.

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Build Automation](./build-automation.md) | [README](../README.md) →
