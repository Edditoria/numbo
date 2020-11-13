/**
@module zhCN
@file Convert number to Simplified Chinese (zh-CN) as part of Numbo JS library.

Numbo is open source in:
https://github.com/Edditoria/numbo

@author Edditoria
@license MIT
Code released under the MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
*/
/** @type {Array.<string>} - ['', 10, 100, 1000] in full-stroke style. */
/** @type {Array.<string>} - ['', 10, 100, 1000] in normal-stroke style. */
/** @type {Array.<string>} - [0..9] in normal-stroke style. */
/**
@type {Array.<string>} Names for large numbers: 1, 1 0000 , 1 0000 0000 ...
	Quote: 万万为亿，万亿为兆。
*/
/**
Convert number ('1'..'9999') to Chinese.
@param {string} str - Expect '1'..'9999'
@param {boolean|null} [isSimple=true] - Result in simple-stroke style, e.g. '一' instead of '壹'.
@return {string}
*/
/**
Convert Numbo input to Chinese in China PRC.
As one of two main functions in zhCN,
it runs when options.type is 'amount' or 'cheque'.
@param {string} str - Numbo input after parsing.
@param {string} options - Either 'amount' or 'cheque'
@return {string} - Final answer of Numbo.
*/
/**
Convert integer part of Numbo input to Chinese.
It splits str into array by every 4 characters, then speak9999() one-by-one.
Work for speakNum() and speakAmt().
@param {string} str
@param {boolean|null} isSimple - Will be brought forward to speak9999().
@return {string}
*/
/**
Convert Numbo input to Chinese in China PRC.
As one of two main functions in zhCN,
it runs when options.type is 'number'.
@param {string} str - Numbo input after parsing.
@return {string} - Final answer of Numbo.
*/
var n1,
	n10,
	n10Simple,
	n1Simple,
	nLarge,
	speak9999,
	speakAmt,
	speakInt,
	speakNum;

import check from './utils/check.mjs';

import normalize from './utils/normalize.mjs';

import adjustDecimal from './utils/adjust-decimal.mjs';

import splitNum from './utils/split-num.mjs';

import speakByDigit from './utils/speak-by-digit.mjs';

import splitInt from './utils/split-int.mjs';

import parseCents from './utils/parse-cents.mjs';

// note to 0:
// - 《出版物上数字用法》规定：一个数字用作计量时，其中“0”的汉字书写形式为“零”；
// - 而当用作编号时，“0”的汉字书写形式为“〇”
// - number.convert(num, 'zhCN', 'number') is a number for measuring
// #todo: 'numbering' of using '〇' instead of '零'.
/** @type {Array.<string>} - [0..9] in full-stroke style. */
n1 = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];

n1Simple = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九'];

n10 = ['', '拾', '佰', '仟'];

n10Simple = ['', '十', '百', '千'];

nLarge = ['', '万', '亿', '兆', '京', '垓', '秭', '穰', '沟', '涧', '正', '载'];

speak9999 = function (str, isSimple = true) {
	var eachNum, i, num, output, ref, speakN1, speakN10, times, unit;
	// may contain double '零'/'〇', but not going to fix it here
	speakN1 = isSimple ? n1Simple : n1;
	speakN10 = isSimple ? n10Simple : n10;
	times = str.length - 1;
	output = '';
	for (
		num = i = 0, ref = times;
		0 <= ref ? i <= ref : i >= ref;
		num = 0 <= ref ? ++i : --i
	) {
		eachNum = +str[num];
		unit = eachNum === 0 ? '' : speakN10[times - num];
		output += speakN1[eachNum] + unit;
	}
	if (output === '零零零零') {
		return '零';
	} else {
		return output.replace(/\零+$/g, ''); // remove tailing '零'
	}
};

speakInt = function (str, isSimple = true) {
	var i, item, itemNum, len, num, output, speakItem, strArr, times, unit;
	if (str === '0') {
		return '零';
	}
	// else
	strArr = splitInt(str, 4);
	times = strArr.length - 1;
	output = '';
	for (num = i = 0, len = strArr.length; i < len; num = ++i) {
		item = strArr[num];
		speakItem = speak9999(item, isSimple); // item = 0 will return '零'
		if (num === 0) {
			// the first item, in case of 10 to 19, need to remove 一, 壹 and 零
			// e.g. 12 in 12,0000,0000 , or simply 18 in 18
			itemNum = parseInt(item, 10);
			if (itemNum > 9 && itemNum < 20) {
				speakItem = speakItem.replace(/^[\一\壹]|\零/g, '');
			}
		}
		unit = speakItem === '零' ? '' : nLarge[times - num];
		output += speakItem + unit;
	}
	return output.replace(/\零+$/g, '').replace(/\零+/g, '零'); // remove tailing zero '零' // remove double '零'
};

speakNum = function (str) {
	var dec, dot, int, strSplited;
	strSplited = splitNum(str);
	int = strSplited[0];
	dec = strSplited[1];
	dot = dec === '' ? '' : '点';
	return speakInt(int, true) + dot + speakByDigit(dec, n1Simple, '');
};

speakAmt = function (str, options = 'cheque') {
	var cent,
		cent1,
		cent2,
		dec,
		dollar,
		dp1,
		dp2,
		int,
		isSimple,
		speakN1,
		strSplited;
	str = adjustDecimal(str, 'ceil', 2);
	strSplited = splitNum(str);
	int = strSplited[0];
	dec = +parseCents(strSplited[1]);
	if (int === '0' && dec === 0) {
		return '零元';
	}
	// else
	isSimple = options === 'cheque' ? false : true;
	dollar =
		int === '0'
			? ''
			: int === '2' && options !== 'cheque'
			? '两元'
			: speakInt(int, isSimple) + '元';
	cent =
		dec === 0
			? options === 'cheque'
				? '整'
				: ''
			: ((speakN1 = isSimple ? n1Simple : n1),
			  (dp1 = Math.floor(dec / 10)),
			  (dp2 = dec % 10),
			  (cent1 =
					dp1 === 0
						? ''
						: dp1 === 2 && options !== 'cheque'
						? '两角'
						: speakN1[dp1] + '角'),
			  (cent2 =
					dp2 === 0
						? ''
						: dp2 === 2 && options !== 'cheque'
						? '两分'
						: speakN1[dp2] + '分'),
			  (cent = cent1 + cent2)); // remark: zero will return ''
	return dollar + cent;
};

/**
Convert Numbo input to Chinese in China PRC.
This zhCN module reacts to numbo.convert(input, options) when type is zh-CN.
Or directly import it as a function.
@param {string|number} input - Numbo input 'nnnnnnn.dddd', e.g. '123.45'.
@param {Object|null} options - The Numbo options object.
@return {string|null} - e.g. '一百二十三点四五', or null if detects error.
*/
export default function (
	input,
	options = {
		type: 'number',
	}
) {
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
	input = normalize(input); // input becomes a string
	switch (options.type) {
		case null:
		case 'number':
		case 'num':
			return speakNum(input);
		case 'cheque':
		case 'check':
		case 'chk':
		case 'chq':
			return speakAmt(input, 'cheque');
		case 'amount':
		case 'amt':
			return speakAmt(input, 'amount');
		default:
			console.log('Error: Option in zhCN is not valid');
			return null;
	}
}
