# Numbo: Convert Number to Native Languages

Numbo is a Javascript library to convert number and monetary amount to written text in multiple languages. Also helpful for writing cheques (checks). Currently, it supports English, Simplified Chinese and Traditional Chinese. Available in npm and bower.

\(Numbo 是一個 Javascript 程式庫，將阿拉伯數字轉換成繁體中文丶簡體中文及英文，另有提供支票用的大寫格式 :\)

Quick examples:

```js
var numbo = new Numbo();

// converting a number, monetary amount or check(cheque) writing
numbo.convert('3.14'); // 'three point one four'
numbo.convert('0.5', { type: 'amount' }); // 'fifty cents'
numbo.convert('100', { type: 'check' }); // 'One Hundred Dollars and No Cent Only'

// Simplified Chinese
numbo.convert('3.14', { lang: 'zhCN', type: 'number' }); // '三点一四'
numbo.convert('0.5', { lang: 'zhCN', type: 'amount' }); // '五角'
numbo.convert('100', { lang: 'zhCN', type: 'check' }); // '壹佰元整'

// Traditional Chinese
numbo.convert('3.14', { lang: 'zhTW', type: 'number' }); // '三點一四'
numbo.convert('0.5', { lang: 'zhTW', type: 'amount' }); // '五角'
numbo.convert('100', { lang: 'zhTW', type: 'check' }); // '壹佰元正'
```


## Install and Usage

Numbo can be installed via npm or Bower, or run in browser directly.

**Important:** This README is based on v3.0.0-rc.0. For `numbo@latest`, please see [Numbo v2.5](https://github.com/Edditoria/numbo/tree/v2.5.0)

### npm

```shell
npm install numbo@next
```

For node.js

```js
import Numbo from 'numbo'; // points to numbo/esm/index.mjs in node 14
// import Numbo from 'numbo/esm/index.mjs'; // same as above
// var Numbo = require('numbo/bundles/numbo.min.js'); // node <=12
var numbo = new Numbo();
console.log(numbo.convert('123.45')); // one hundred and twenty-three point four five
```

### Bower

You can download and easily update `numbo` via [Bower package manager](https://bower.io/).

```shell
bower install numbo
```

And it is ready to serve in front-end environment:

```html
<html>
	<head>
		<script src='bower_components/numbo/bundles/numbo.min.js'></script>
	</head>
</html>

```

```js
var numbo = new Numbo();
console.log(numbo.convert('123.45')); // one hundred and twenty-three point four five
```

### Direct Download

Nothing can stop you. Download the file `numbo.min.js` and refer it in your html file:

```html
<html>
	<head>
		<script src='numbo.min.js'></script>
	</head>
</html>
```

And you are ready to go:

```js
var numbo = new Numbo();
console.log(numbo.convert('123.45')); // one hundred and twenty-three point four five
```


## Features Highlight

### Basic Usage: `numbo.convert(input, options)`

`input` is the string (recommended) or number you want to convert.
`options` is a Javascript object for format of output you want to get:

1. `options.lang`: Either 'enUS' (default), 'zhTW' or 'zhCN'.
1. `options.type`: Either 'number' (default), 'amount' or 'check'.
1. `options.zeroCent`: `true` to get check amount "with Zero Cent" instead of "with No Cent". Default is `false`.

```js
var options = {};
var input = '12.3456';

numbo.convert(input, options);
// no option implies { lang: 'enUS', type: 'number' }
// return 'twelve point three four five six'

options.type = 'amount';
numbo.convert(input, options);
// 'amount' will round up (ceiling) to 2 decimal place
// return 'twelve dollars and thirty-five cents'

options.type = 'check';
numbo.convert('100', options);
// 'check' will round up (ceiling) to 2 decimal place
// return 'One Hundred Dollars and No Cent Only'

options.zeroCent = true;
numbo.convert('100', options);
// return 'One Hundred Dollars and Zero Cent Only'
```

### Define Numbo Instances

In v3.x, you can create a Numbo instance with constructor options using `new Numbo(options)`.

```js
var input = '100';
var optionsEnChk = { lang: 'enUS', type: 'check', zeroCent: true };
var numboEnChk = new Numbo(optionsEnChk);

numboEnChk.convert(input, { type: 'amount' });
// .convert() still accepts options (as one-time options)
// return 'one hundred dollars'

numboEnChk.convert(input);
// then convert using instance options this time
// return 'One Hundred Dollars and Zero Cent Only'

numboEnChk.convert(input, { lang: 'zhTW' });
// .convert() to 'check' according to optionsEnChk
// return '壹佰元正'

// Define as many as you want
var numboTwChk = new Numbo({ lang: 'zhTW', type: 'check' });
var numboCnChk = new Numbo({ lang: 'zhCN', type: 'check' });
var numboCnAmt = new Numbo({ lang: 'zhCN', type: 'amount' });
```

More format will be provided in future releases, e.g. no hyphen, no "and" word, return error, etc. For any request, please [hit me an issue](https://github.com/Edditoria/numbo/issues).

### Format of `input`

- Accepts string (recommended) and number, e.g. '30624700'.
- You must use a string if the input is more than 16 characters.
- Limitations:
	- English module supports up to 66 digits, i.e. hundred vigintillion.
	- Simplified and Traditional Chinese modules support up to 48 digits, i.e. 千載.

### Alias `options.type`

You can write in short form:

- `'num'` is equivalent to `'number'`
- `'amt'` is equivalent to `'amount'`
- `'chk'`, `'chq'` and `'cheque'` are equivalent to `'check'`

```js
numbo.convert('100', { type: 'amt', lang: 'zhTW' });
```

### Play with Numbo-Options

The Numbo-options is designed to bring anywhere in Numbo.

```js
var numbo = new Numbo({ lang: 'zhTW' });

// Get current options
numbo.getOptions(); // { lang: 'zhTW', type: 'number' }

// Add or override option(s)
numbo.setOptions({ type: 'cheque' }); // { lang: 'zhTW', type: 'cheque' }

// See the default Numbo options
numbo.getDefaultOptions(); // { lang: 'enUS', type: 'number' }

// Reset to Numbo default
numbo.resetOptions(); // { lang: 'enUS', type: 'number' }
```

### Import Modules

Thanks to stable Conditional Exports in Node 14, you can import ESM modules via Node or build tools. With npm install, you can simply:

- `import Numbo from 'numbo'` to get Numbo object in `esm/index.mjs`.
- `import enUS from 'numbo/en-us'` to get enUS function in `esm/en-us.mjs`.
- `import normalize from 'numbo/utils/normalize'` to get the normalize utility module.
- And etc.

Although I recommend you develop using Node 14+, suppose this package still works for Node < 14, Webpack, Rollup and other build tools using the "exports", "main" and "module" configs in `<package.json>`.

This Numbo feature is **in development stage**. I need your comments and suggestions. Welcome Issues.

### Parsing and Catching Errors (Work-In-Progress)

Numbo will try to do some checking and normalize the input. Let say:

```js
cutFromNews = '$1,000,000.00';
robot.speak += numbo.convert(cutFromNews, { type: 'amt' });
// 'one million dollars'

cutFromEmail = '.5';
robot.speak += numbo.convert(cutFromEmail);
// 'zero point five'

readScore = '0050.50';
robot.speak += numbo.convert(readScore);
// 'fifty point five'
```

Currently Numbo is quite stupid. Anything it cannot convert. Will `console.log` a message then return `null`.

```js
numbo.convert('knock knock'); // Error: Invalid input value. Return null
numbo.convert('HKD777'); // Error: Invalid input value. Return null
```


## Copyright and License

Copyright (c) 2016-2020 Edditoria. All rights reserved. Code released under the [MIT License](LICENSE.txt). Docs released under [Creative Commons](https://creativecommons.org/licenses/by/4.0/).

As human-readable summary (but not a substitute for the license):

You can use it, share it, modify the code and distribute your work for private and commercial uses. If you like, please share your work with me. :pizza:
