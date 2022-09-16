const {SequentialSearch} = require('./sequential.js');

class HashTable {
  constructor(buckets = 5) {
    this.chains = [];
    this.size = 0;
    this.fillChains(buckets);
  }

  fillChains(buckets) {
    let index = 0;

    while(index < buckets) {
      this.chains[index] = new SequentialSearch();
      index += 1;
    }
  }

  _hash(key) {
    let hash = 0;
    for (let i = 0; i < key.length; i += 1) {
      hash += key.charCodeAt(i);
    }
    return hash % this.chains.length;
  }

  set(key, value) {
    const index = this._hash(key);
    this.chains[index].set(key, value);
    this.size++;
    return this;
  }

  get(key) {
    const index = this._hash(key);
    return this.chains[index].get(key);
  }

  has(key) {
    const index = this._hash(key);
    return this.chains[index].has(key);
  }

  *[Symbol.iterator]() {
    let len = this.chains.length;
    let index = 0;
    while(index < len) {
      yield* this.chains[index].keys()
      index += 1;
    }
  }

  keys() {
    return this[Symbol.iterator]();
  }
}

module.exports = { HashTable };