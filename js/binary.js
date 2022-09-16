class BinarySearch {
  constructor() {
    this.orderedkeys = [];
    this.values = [];
    this.size = 0;
  }

  rank(key) {
    let lo = 0
    let hi = this.size - 1;
    while (lo <= hi) {
      let mid = Math.trunc(lo + (hi - lo) / 2);
      if(key < this.orderedkeys[mid]) {
        hi = mid - 1;
      } else if (key > this.orderedkeys[mid]) {
        lo = mid + 1;
      } else {
        return mid;
      }
    }
    return lo;
  }

  set(key, value) {
    let index = this.rank(key);
    // update the value for the given key
    if(index < this.size && this.orderedkeys[index] === key) {
        this.values[index] = value;
        return;
    }

    // insert new key value pairs
    let startShifting = this.size;
    while(startShifting > index) {
      this.orderedkeys[startShifting] = this.orderedkeys[startShifting - 1];
      this.values[startShifting] = this.values[startShifting - 1];
      startShifting -= 1;
    }
    this.orderedkeys[index] = key;
    this.values[index] = value;

    this.size += 1;
    return this; // only to be consistent with Javascript Map API
  }

  get(key) {
    let index = this.rank(key);
    if(index < this.size && this.orderedkeys[index] === key) {
      return this.values[index];
    }
    return undefined; // undefined is not allowed as a value
  }

  keys() {
    return this.orderedkeys.values();
  }

  has(key) {
    return this.get(key) !== undefined; // undefined is not allowed as a value
  }
}

module.exports = { BinarySearch };