# About `numbo`

Numbo is a Javascript library to convert number and monetary amount to written text in multiple languages. Also helpful for writing cheques (checks). Currently, it supports English, Simplified Chinese and Traditional Chinese. Available in npm and bower.

\(numbo 是一個 Javascript 程式庫，將阿拉伯數字轉換成繁體中文丶簡體中文及英文，另有提供支票用的大寫格式 :\)

Quick examples:

```js
// converting a number, monetary amount or check(cheque) writing
numbo.convert(3.14) // "three point one four"
numbo.convert(0.5, 'amount') // "fifty cents"
numbo.convert(100, 'check') // "One Hundred Dollars and No Cent Only"

// Simplified Chinese, optional as a plugin
numbo.convert(3.14, 'zhCN') // "三点一四"
numbo.convert(0.5, 'zhCN', 'amount') // "五角"
numbo.convert(100, 'zhCN', 'check') // "壹佰元整"

// Traditional Chinese, optional as a plugin
numbo.convert(3.14, 'zhTW') // "三點一四"
numbo.convert(0.5, 'zhTW', 'amount') // "五角"
numbo.convert(100, 'zhTW', 'check') // "壹佰元正"
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
numbo.zhTW = require('numbo/lib/numbo.zhTW'); // add support of Traditional Chinese
numbo.zhCN = require('numbo/lib/numbo.zhCN'); // add support of Simplified Chinese
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
console.log(numbo.convert('123.45', 'zhCN')); // "一百二十三点四五" (require numbo.zhCN)
console.log(numbo.convert('123.45', 'zhTW')); // "一百二十三點四五" (require numbo.zhTW)
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
    <!-- optional: add below lines for additional languages/plugins -->
    <script src='bower_components/numbo/dist/numbo.zhCN.js'></script> <!-- Simplified Chinese -->
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
    <!-- optional: add below lines for additional languages/plugins -->
    <script src='numbo.zhCN.js'></script> <!-- Simplified Chinese -->
    <script src='numbo.zhTW.js'></script> <!-- Traditional Chinese -->
  </head>
</html>
```

And you are ready to go:

```js
console.log(numbo.convert('123.45')); // "one hundred and twenty-three point four five"
```

# Features

## Basic Usage: `numbo.convert(input, option)`

- `input` is the string or number you want to convert.
- `option` is the format of output you want to get. It can be:
  1. `'number'`
  2. `'amount'`
  3. `'check'`
- If no option is provided, numbo will convert in form of number.

```js
// 1.
numbo.convert(123.4567)
// no option implies using 'default', and 'default' is 'number'
// return "one hundred and twenty-three point four five six seven"

// 2.
numbo.convert(123.4567, 'amount')
// 'amount' will round up (ceiling) to 2 decimal place
// return "one hundred twenty-three dollars and forty-six cents"

// 3.
numbo.convert(123.4567, 'check')
// 'check' will round up (ceiling) to 2 decimal place
// return "One Hundred Twenty-three Dollars and Forty-six Cents Only"
```

## Multiple Options: `numbo.convert(input, option, option...)`

In v2.x, you can convert number to Tradtional Chinese. The options are same as previous versions. You can do it via multiple options (now maximum of two).

1. Language/plugin: `'enUS'`, `'zhCN'` or `'zhTW'`
2. Format: `'number'`, `'amount'` or `'check'`

```js
numbo.convert(123.4567, 'zhTW') // "一百二十三點四五六七"

numbo.convert(123.4567, 'amount', 'zhTW') // "一百二十三元四角六分"

numbo.convert(123.4567, 'zhTW', 'check') // "壹佰貳拾叁元肆角陸分"
```

More format will be provided in future releases, e.g. no hyphen, no "and" word, etc. For any request, please [hit me an issue](https://github.com/Edditoria/numbo/issues).

## Format of `input`

- Accepts number or string, e.g. '30624700'.
- You must use a string if the input is more than 16 characters.
- Limitations:
  - English plugin supports up to 66 digits, i.e. one hundred vigintillion.
  - Simplified and Traditional Chinese plugins support up to 48 digits, i.e. 一千載.

## Format of `options`

You can write in short form:

- `'num'` is equivalent to  `'number'`
- `'amt'` is equivalent to `'amount'`
- `'chk'`, `'chq'` and `'cheque'` is equivalent to `'check'`

```js
numbo.convert(100, 'amt', 'zhTW')
```

## Parsing and Catching Errors (Work-In-Progress)

`numbo` will try to do some checking and normalize the input. Let say:

```js
cutFromNews = '$1,000,000.00';
robot.speak += numbo.convert(cutFromNews, 'amt'); // one million dollars

cutFromEmail = '.5';
robot.speak += numbo.convert(cutFromEmail); // zero point five

readScore = '0050.50';
robot.speak += numbo.convert(readScore); // fifty point five

```

In current status `numbo` is quite stupid. Anything it cannot convert. Will `console.log` a message then return `null`.

```js
numbo.convert('knock knock') // Error: Invalid input value. Return null
numbo.convert('HKD$689') // Error: Invalid input value. Return null
numbo.convert('689', 'zhTW', 'enUS') // Error: Invalid option. You have selected more than one language/plugin. Returns null

numbo.convert('369', 'spellError')
numbo.convert('369', 'amt', 'num')
// Error: Invalid option. Possibly more than one template is selected. Or, some option(s) are parsed into [otherOptions], but it is not allowed in current version yet.
```

# Planning

This repo is quite new. To make it some-how complete, need more works on these:

- [x] convert number to written text
- [x] provide basic tools for plugin development
- [x] convert monetary amount to written text
- [x] check before convert
- [x] add Chinese via plugin
- [x] unify options for different languages
- [ ] write test and readme for `numbo.tools`
- [ ] more options, e.g. no hyphen, output in array
- [ ] more languages
- [ ] better docs and instructions for plugin development

Please kindly wait for more releases.

# Contribution

*tl;tr* For pull request, please do check **Allow edits from maintainers**, and merge from **your new branch** into **my master branch**.

For details, please kindly read [CONTRIBUTING.md](CONTRIBUTING.md)

:beer: Thank you so much! :pray:
