/**
@module enUS
@file Convert number to English (en-US) as part of Numbo JS library.

Numbo is open source in:
https://github.com/Edditoria/numbo

@author Edditoria
@license MIT
Code released under the MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
*/
/** @type {Options} */
/** @type {Array.<string>} Basically ['', One', 'Two'..'Ninety-nine'] */
/**
Convert number (1..999) to English.
Work for speakInt().
@param {number} num - Expect an integer 1..999
@param {boolean|null} [addAnd=true]
@return {string}
*/
/**
Convert Numbo input to English.
As one of two main functions in enUS,
it runs when options.type is 'amount' or 'cheque'.
@param {string} str - Numbo input after parsing.
@param {type} type - Either 'amount' or 'cheque':
	- 'amount': some dollars and some cents, or
	- 'cheque': Some Dollars and Some Cents Only.
@param {boolean} zeroCent - zeroCent in Numbo Options.
@return Final answer of Numbo.
*/
/**
Convert integer part of Numbo input to English.
Work for speakNum() and speakAmt().
@param {Array} numArr - e.g. [12, 345, 678].
@param {boolean|null} [addAdd=true] - Will be brought forward to speak999().
@return {string}
*/
/**
Convert Numbo input to English.
As one of two main functions in enUS,
it runs when options.type is 'number'.
@param {string} str - Numbo input after parsing.
@return {string} - Final answer of Numbo.
*/
var defaultOptions,
	n1,
	n10,
	n1000,
	n1withZero,
	n99,
	speak999,
	speakAmt,
	speakInt,
	speakNum;

import check from './utils/check.mjs';

import normalize from './utils/normalize.mjs';

import adjustDecimal from './utils/adjust-decimal.mjs';

import splitNum from './utils/split-num.mjs';

import splitInt from './utils/split-int.mjs';

import speakByDigit from './utils/speak-by-digit.mjs';

import parse99 from './utils/parse-99.mjs';

import parseCents from './utils/parse-cents.mjs';

import trimWhitespace from './utils/trim-whitespace.mjs';

defaultOptions = {
	type: 'number',
	zeroCent: false,
};

n1 = [
	'',
	'One',
	'Two',
	'Three',
	'Four',
	'Five',
	'Six',
	'Seven',
	'Eight',
	'Nine',
	'Ten',
	'Eleven',
	'Twelve',
	'Thirteen',
	'Fourteen',
	'Fifteen',
	'Sixteen',
	'Seventeen',
	'Eighteen',
	'Nineteen',
]; // zero

n1withZero = [
	'Zero',
	'One',
	'Two',
	'Three',
	'Four',
	'Five',
	'Six',
	'Seven',
	'Eight',
	'Nine',
	'Ten',
	'Eleven',
	'Twelve',
	'Thirteen',
	'Fourteen',
	'Fifteen',
	'Sixteen',
	'Seventeen',
	'Eighteen',
	'Nineteen',
];

n10 = [
	'',
	'Ten',
	'Twenty',
	'Thirty',
	'Forty',
	'Fifty',
	'Sixty',
	'Seventy',
	'Eighty',
	'Ninety',
]; // zero

n1000 = [
	'',
	'Thousand',
	'Million',
	'Billion',
	'Trillion',
	'Quadrillion',
	'Quintillion',
	'Sextillion',
	'Septillion',
	'Octillion',
	'Nonillion',
	'Decillion',
	'Undecillion',
	'Duodecillion',
	'Tredecillion',
	'Quattuordecillion',
	'Quindecillion',
	'Sexdecillion',
	'Septendecillion',
	'Octodecillion',
	'Novemdecillion',
	'Vigintillion',
];

n99 = parse99(n1, n10, '-');

speak999 = function (num, addAnd = true) {
	var d100, hundred;
	if (num <= 99) {
		return n99[num];
	}
	if (num % 100 === 0) {
		return n1[Math.floor(num / 100)] + ' Hundred';
	}
	// else
	d100 = Math.floor(num / 100);
	hundred = addAnd ? ' Hundred and ' : ' Hundred ';
	return n1[d100] + hundred + n99[num % 100];
};

speakInt = function (numArr, addAnd = true) {
	var i, item, len, num, output, times, unit;
	output = [];
	times = numArr.length;
	for (num = i = 0, len = numArr.length; i < len; num = ++i) {
		item = numArr[num];
		times--;
		if (item !== '000') {
			unit = ' ' + n1000[times];
			item = speak999(parseInt(item, 10), addAnd);
			output.push(item + unit);
		}
	}
	return trimWhitespace(output.join(' '));
};

speakNum = function (str) {
	var dec, int, intArr, strSplited;
	if (str === '0') {
		return 'zero';
	}
	if (str === '1') {
		return 'one'; // faster
	}
	// else
	strSplited = splitNum(str);
	intArr = splitInt(strSplited[0]);
	int = speakInt(intArr);
	if (int === '') {
		int = 'zero';
	}
	dec =
		strSplited[1] === ''
			? ''
			: ' point ' + speakByDigit(strSplited[1], n1withZero, ' ');
	return (int + dec).toLowerCase();
};

speakAmt = function (str, type, zeroCent) {
	var andWord,
		centUnit,
		cents,
		dec,
		dollarUnit,
		dollars,
		int,
		intArr,
		output,
		strSplited;
	if (str === '0') {
		output = 'Null';
	} else {
		dollarUnit = ['Dollar', 'Dollars'];
		centUnit = ['Cent', 'Cents'];
		// Math.ceil to 2 decimal place
		str = adjustDecimal(str, 'ceil', 2);
		// parse the `str`
		strSplited = splitNum(str);
		// parse dollars
		intArr = splitInt(strSplited[0]);
		int = speakInt(intArr, false); // no 'and'
		dollars =
			int === ''
				? ''
				: int === 'One'
				? ' ' + dollarUnit[0]
				: ' ' + dollarUnit[1];
		// parse cents:
		// 1. strSplited[1]
		// 2. parseCents()
		// 3. +dec
		// 4. n99()
		// remark: n99[0] returns ''
		dec = n99[+parseCents(strSplited[1])];
		cents =
			dec === '' && int === ''
				? 'Null'
				: dec === ''
				? 'No Cent'
				: dec === 'One'
				? ' Cent'
				: ' Cents';
		// put together
		andWord = dollars === '' ? '' : ' and ';
		output = int + dollars + andWord + dec + cents;
	}
	// adjust the output according to `type`
	output =
		type === 'cheque'
			? output === 'Null'
				? 'Null'
				: output + ' Only'
			: type === 'amount'
			? output.replace(' and No Cent', '').toLowerCase()
			: (console.log('Error: Option in speakAmt() is invalid.'),
			  (output = null));
	if (zeroCent === true) {
		output = output.replace('and No Cent', 'and Zero Cent');
	}
	return output;
};

/**
Convert Numbo input to English.
This enUS module reacts to numbo.convert(input, options) when type is en-US.
Or directly import it as a function.
@param {string|number} input - Numbo input 'nnnnnnn.dddd', e.g. '123.45'.
@param {Object|null} options - The Numbo options object.
@return {string|null} - e.g. 'one hundred point two three', or null if detects error.
*/
export default function (input, options = defaultOptions) {
	var zeroCent;
	if (input === '') {
		return null;
	}
	if (input === '1e+100') {
		return 'Ding! One Google... Oops... One Googol!!';
	}
	if (check(input) === false) {
		console.log('Error: Invalid input value. Return null');
		return null;
	}
	// else
	input = normalize(input); // input must become a string
	switch (options.type) {
		case null:
		case 'number':
		case 'num':
			return speakNum(input);
		case 'cheque':
		case 'check':
		case 'chk':
		case 'chq':
			// zeroCent only accepts true. All other values are false.
			zeroCent = options.zeroCent === true ? true : false;
			return speakAmt(input, 'cheque', zeroCent);
		case 'amount':
		case 'amt':
			return speakAmt(input, 'amount', false);
		default:
			console.log('Error: options.type in enUS is not valid');
			return null;
	}
}
