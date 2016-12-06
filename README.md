# About This Repo

Convert number and monetary amount to written text. Also helpful for writing cheques (checks).

# Features

This repo is still in contruction. Please stay tuned. Currently, you can convert number to text.

Planned features:

- [x] convert number to written text
- [x] provide basic tools for plugin development
- [ ] check before convert
- [ ] convert monetary amount to written text
- [ ] add Chinese via plugin

# Usage

`numbo` can be installed via npm or run in browser directly.

## Install via npm

```shell
npm install numbo
```

For node.js

```js
var numbo = require('numbo');
console.log(numbo.convert(123.45)); // "one hundred twenty three point four five"
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
console.log(numbo.convert(123.45)); // "one hundred twenty three point four five"
```
