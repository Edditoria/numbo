import enUSAmount from './en-us.amount.mjs';

import enUSCheque from './en-us.cheque.mjs';

import enUSNumber from './en-us.number.mjs';

import zhTWAmount from './zh-tw.amount.mjs';

import zhTWCheque from './zh-tw.cheque.mjs';

import zhTWNumber from './zh-tw.number.mjs';

import zhCNAmount from './zh-cn.amount.mjs';

import zhCNCheque from './zh-cn.cheque.mjs';

import zhCNNumber from './zh-cn.number.mjs';

export default {
	/**
  @typedef {Object} Data - A JSON-like series of test data in structure of data[lang][type][testObj...]
  @property {Object.<Lang>.<Type>.<string|number>} input - Test input arg for running numbo()
  @property {Object.<Lang>.<Type>.<?string>} expect - Expected result for running numbo()
  @typedef {Object} Lang - One of { enUS, zhTW, zhCN } as property of Data
  @typedef {Object} Type - One of { amount, cheque, number } as property of Lang
  */
	enUS: {
		amount: enUSAmount,
		cheque: enUSCheque,
		number: enUSNumber,
	},
	zhTW: {
		amount: zhTWAmount,
		cheque: zhTWCheque,
		number: zhTWNumber,
	},
	zhCN: {
		amount: zhCNAmount,
		cheque: zhCNCheque,
		number: zhCNNumber,
	},
};
