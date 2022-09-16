const lineReader = require('line-reader');

const {SequentialSearch} = require('./sequential.js');
const {HashTable} = require('./hash_table.js');
const {BinarySearch} = require('./binary.js');

class FrequencyCounter {
  constructor(pairsDataType, filePath, minLen = 10) {
    this.pairs = pairsDataType;
    this.filePath = filePath;
    this.minLen = minLen;
    this.wordsCount = 0;
    this.distinctCount = 0;
    this.max = [];
  }

  maxFrequencyWord() {
    const start = Date.now();
    lineReader.eachLine(this.filePath, {separator: /\s+/, encoding: 'utf8'}, (word, last) => {
      if(last) {
        this.setMax();
        this.logMax(start);
      }
      if (word.length >= this.minLen) {
        this.wordsCount += 1;
        if (this.pairs.has(word)) {
          this.pairs.set(word, this.pairs.get(word) + 1);
        } else {
          this.pairs.set(word, 1);
          this.distinctCount += 1
        }
      }
    });
  }

  logMax(start) {
    console.log(`Words Number: ${this.wordsCount}`);
    console.log(`Distinct words: ${this.distinctCount}`);
    console.log(`Max: ${this.max[0]} -> ${this.max[1]}`);
    const end = Date.now();
    console.log((end - start) / 1000);
  }

  setMax() {
    let max = '';
    this.pairs.set(max, 0);
    for (const word of this.pairs.keys()) {
      if (this.pairs.get(word) > this.pairs.get(max)) {
        max = word;
      }
    }
    this.max = [max, this.pairs.get(max)];
  }
}

const file = 'tinyTale.txt';

// const counter = new FrequencyCounter(new Map(), file, 1);
// const counter = new FrequencyCounter(new SequentialSearch(), file, 1);
// const counter = new FrequencyCounter(new BinarySearch(), file, 1);
// const counter = new FrequencyCounter(new HashTable(), file, 1);

const bigFile = 'leipzig1M.txt';
// const pairs = new HashTable(41399);
const pairs = new BinarySearch();
const minLen = 10
const counter = new FrequencyCounter(pairs, bigFile, minLen);
counter.maxFrequencyWord();

// new HashTable(41399);
// Words Number: 1610829
// Distinct words: 165555
// Max: government -> 24763
// 45.207

// new BinarySearch()
// Words Number: 1610829
// Distinct words: 165555
// Max: government -> 24763
// 128.613 ~ 2 minutes and 8 seconds


// const counter = new FrequencyCounter(new Map(), 'leipzig1M.txt', 10);
// Words Number: 1610829
// Distinct words: 165555
// Max: government -> 24763
// 37.822

// const objectMap = {
//   set(key, value) {
//     return this[key] = value;
//   },
//   get(key) {
//     return this[key];
//   },
//   has(key) {
//     return this.hasOwnProperty(key);
//   }
// }

// setMax() {
//   let max = '';
//   this.pairs[max] = 0;
//   for (const word in this.pairs) {
//     if (this.pairs.get(word) > this.pairs.get(max)) {
//       max = word;
//     }
//   }
//   this.max = [max, this.pairs.get(max)];
// }

// const counterObj = new FrequencyCounter(objectMap, bigFile, minLen);
// counterObj.maxFrequencyWord();

// Words Number: 1610829
// Distinct words: 165555
// Max: government -> 24763
// 39.882
