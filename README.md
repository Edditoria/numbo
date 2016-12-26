# About `numbo`

Convert number and monetary amount to written text. Also helpful for writing cheques (checks). It supports English and Traditional Chinese.

Quick example:

```js
numbo.convert(100) // "one hundred"

numbo.convert(100, 'amount') // "one hundred dollars"

numbo.convert(100, 'check') // "One Hundred Dollars and No Cent Only"

numbo.zhTW(100, 'check') // "壹佰元正" (Traditional Chinese)
```

# Install and Usage

`numbo` can be installed via npm or Bower, or run in browser directly.

## npm

```shell
npm install numbo
```

For node.js

```js
var numbo = require('numbo');
numbo.zhTW = require('numbo/lib/numbo.zhTW'); // add this line if you want to convert Traditional Chinese
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
console.log(numbo.zhTW('123.45')); // "一百二十三點四五" (require numbo.zhTW)
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
        <!-- add below line for additional languages/plugins -->
        <script src='bower_components/numbo/dist/numbo.zhTW.js'></script> <!-- Traditional Chinese -->
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
        <!-- add below line for additional languages/plugins -->
        <script src='numbo.zhTW.js'></script> <!-- Traditional Chinese -->
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
    1. `'number'` (`'default'`, or `'num'`)
    2. `'amount'` (or `'amt'`)
    3. `'check'` (or `'cheque'`, `'chk'`, `'chq'`)

```js
// 1.
numbo.convert(123.4567)
// no option implies using 'number'
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

## `numbo.zhTW(input, option)`

In v2.x, you can convert number to Tradtional Chinese. The options are same as `numbo.convert`.

```js
numbo.zhTW(123.4567) // "一百二十三點四五六七"

numbo.zhTW(123.4567, 'amt') // "一百二十三元四角六分"

numbo.zhTW(123.4567, 'chk') // "壹佰貳拾叁元肆角陸分"
```

# Planned Features

This repo is quite new. To make it some-how complete, need more works on these:

- [x] convert number to written text
- [x] provide basic tools for plugin development
- [x] convert monetary amount to written text
- [x] check before convert (v1.1)
- [x] add Chinese via plugin (v2)
- [ ] unify options for different languages (v2.1)
- [ ] write test and readme for `numbo.tools` (v3)
- [ ] more options, e.g. no hyphen, output as array (v4)

Please kindly wait for more releases.
