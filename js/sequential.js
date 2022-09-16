class SequentialSearch {
  constructor() {
    this.pairs = [];
  }
  set(key, value) {
    let len = this.pairs.length;
    let index = 0;
    while(index < len) {
      let pair = this.pairs[index];

      if(pair[0] === key) {
        pair[1] = value;
        return this; // only to be consistent with Javascript Map API
      }
      index += 1;
    }

    this.pairs.push([key, value]);
    return this; // only to be consistent with Javascript Map API
  }

  get(key) {
    let len = this.pairs.length;
    let index = 0;
    while(index < len) {
      let pair = this.pairs[index];
      if(pair[0] === key) {
        return pair[1];
      }
      index += 1;
    }
    return undefined;
  }

  keys() {
    return this[Symbol.iterator]();
  }

  *[Symbol.iterator]() {
    let len = this.pairs.length;
    let index = 0;
    while(index < len) {
      yield this.pairs[index][0];
      index += 1;
    }
  }

  has(key) {
    return this.get(key) !== undefined; // undefined is not allowed as a value
  }
}

module.exports = { SequentialSearch };