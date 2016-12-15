# About `Numbo`

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

## Bower

You can download and easily update `numbo` via [Bower package manager](https://bower.io/).

```shell
bower install numbo
```

And it is ready to serve in front-end environment:

```html
<html>
    <head>
        <script src='bower_components/numbo/dist/numbo.js'></script>
    </head>
</html>

```

```js
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
```

## Direct Download

Nothing can stop you. Download the file `numbo.js` and refer it in your html file:

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
    1. Have to be a valid number, e.g. 123 (number), '123' (string), '$123,456'.
    2. You must use a string if the input is more than 16 characters.
    3. Currently it supports up to 66 characters only, i.e. one hundred vigintillion.
- `option` is the format of output you want. It accepts:
    1. `'number'` (default)
    2. `'amount'` (or `'amt'`)
    3. `'check'` (or `'cheque'`)

```js
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
- [x] convert monetary amount to written text
- [x] check before convert (v1.1)
- [ ] write test and readme for `numbo.tools` (v2)
- [ ] add Chinese via plugin (v3)
- [ ] more options, e.g. no hyphen, output as array (v4)

Please kindly wait for more releases.
