/**
Numbo is a Javascript library to convert number and monetary amount
to written text in multiple languages.
Also helpful for writing cheques (checks). Supports English, and 支援中文.

Numbo is open source in:
https://github.com/Edditoria/numbo

@module Numbo
@file The main entry of Numbo library.
@author Edditoria
@license MIT
Code released under the MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
*/
/**
Convert is named for Numbo.convert() method.
It actually passes numerical string and options to a language module.
@param {string|number} input - The key input being converted, e.g. '123.45'.
@param {Options|null} options
@return {string} - Final output of Numbo.
*/
var Numbo, convert, defaultOptions, langs, resetOptions, setOptions, utils;

import parse99 from './utils/parse-99.mjs';

import trimWhitespace from './utils/trim-whitespace.mjs';

import parseCents from './utils/parse-cents.mjs';

import parseType from './utils/parse-type.mjs';

import speakByDigit from './utils/speak-by-digit.mjs';

import check from './utils/check.mjs';

import normalize from './utils/normalize.mjs';

import adjustDecimal from './utils/adjust-decimal.mjs';

import splitNum from './utils/split-num.mjs';

import splitInt from './utils/split-int.mjs';

import parseLang from './utils/parse-lang.mjs';

import enUS from './en-us.mjs';

import zhTW from './zh-tw.mjs';

import zhCN from './zh-cn.mjs';

/**
@typedef {Object} Options
Numbo options are widely used as argument in modules.
It is designed to bring forward to vary modules and functions.
All property are optional. Defaults are:
@property {?string} lang - Numbo bundled modules: 'enUS', 'zhTW' and 'zhCN'.
@property {?string} type - 'number', 'amount', 'cheque' and their aliases.
@property {?boolean} zeroCent - Useful when cheque amount is an integer.
	True to display "and zero cent" instead of "and no cent".
*/
// Collections of utils and langs
// ==============================
utils = {
	trimWhitespace: trimWhitespace,
	parse99: parse99,
	parseCent: parseCents,
	parseCents: parseCents,
	parseType: parseType,
	speakByDigit: speakByDigit,
	check: check,
	validate: check,
	normalize: normalize,
	normalise: normalize,
	adjustDecimal: adjustDecimal,
	splitNum: splitNum,
	splitInt: splitInt,
};

langs = {
	enUS: enUS,
	zhTW: zhTW,
	zhCN: zhCN,
};

// Operating Options
// =================
/** @type {Options} */
defaultOptions = {
	lang: 'enUS',
	type: 'number',
};

setOptions = function (options) {
	Object.assign(this.options, options);
	return this.options;
};

resetOptions = function () {
	this.options = Object.assign({}, defaultOptions);
	return this.options;
};

convert = function (input, options) {
	var oneTimeOptions;
	// Clone this.options, then override it using options arg
	oneTimeOptions = Object.assign({}, this.options, options);
	oneTimeOptions.lang = parseLang(oneTimeOptions.lang);
	if (oneTimeOptions.lang === false) {
		return null;
	}
	if (langs[oneTimeOptions.lang] == null) {
		console.log('Error: Cannot find the lang function:', options.lang);
		return null;
	}
	return langs[oneTimeOptions.lang](input, oneTimeOptions);
};

Numbo = class Numbo {
	constructor(options) {
		if (options == null) {
			// options == null
			this.options = defaultOptions;
		} else {
			this.options = Object.assign({}, defaultOptions, options);
		}
	}
};

// Public methods
Numbo.prototype.convert = convert;

Numbo.prototype.utils = utils;

Numbo.prototype.enUS = enUS;

Numbo.prototype.zhTW = zhTW;

Numbo.prototype.zhCN = zhCN;

Numbo.prototype.getDefaultOptions = function () {
	return defaultOptions;
};

Numbo.prototype.getOptions = function () {
	return this.options;
};

Numbo.prototype.setOptions = setOptions;

Numbo.prototype.resetOptions = resetOptions;

export default Numbo;
