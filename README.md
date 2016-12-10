# About This Repo

Convert number and monetary amount to written text. Also helpful for writing cheques (checks).

> This repo is still in contruction. Please stay tuned for more releases.

# Install and Usage

`numbo` can be installed via npm or run in browser directly.

## npm

```shell
npm install numbo
```

For node.js

```js
var numbo = require('numbo');
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
```

## For Browsers

Download the file `numbo.js` and refer it in your html file:

```html
<html>
    <head>
        <script src='numbo.js'></script>
    </head>
</html>
```

And you are ready to go:

```js
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
```

# Features

## `numbo.convert(input, option)`

- `input` is the string or number you want to convert.
    1. You must use a string if the input is more than 21 characters.
    2. Currently it supports up to 66 characters only, or will make an unexpected error
- `option` is the format of output you want. It accepts:
    1. `'number'` (default)
    2. `'amount'` (or `'amt'`)
    3. `'check'` (or `'cheque'`)

```javascript
// 1.
numbo.convert(123.4567)
// no option implies to use 'number'
// return "one hundred and twenty-three point four five six seven"

// 2.
numbo.convert(123.4567, 'amount')
// 'amount' will round up (ceiling) to 2 decimal place
// return "one hundred twenty-three dollars and forty-six cents"

// 3.
numbo.convert(123.4567, 'check')
// 'check' will round to ceiling at 2 decimal place
// return "One Hundred Twenty-three Dollars and Forty-six Cents Only"
```

# Planned Features

This repo is just new. To make it some-how complete, need more works on these:

- [x] convert number to written text
- [x] provide basic tools for plugin development
- [ ] check before convert
- [x] convert monetary amount to written text
- [ ] write test and readme for `numbo.tools`
- [ ] add Chinese via plugin
- [ ] more options, e.g. no hyphen, output as array

Please kindly wait for more releases.
