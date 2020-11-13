/*
Run tests for each module: Numbo, enUS, zhCN, zhTW.
This file and the imported modules are managed by Gulp, not Rollup.
Gulp creates all imported files, rather than transpile them into one file.
*/
var dataList,
	eachTestResult,
	i,
	j,
	k,
	l,
	lang,
	langMod,
	langMods,
	len,
	len1,
	len2,
	len3,
	numbo,
	testResults,
	type;

import Numbo from '../esm/index.mjs';

import enUS from '../esm/en-us.mjs';

import zhTW from '../esm/zh-tw.mjs';

import zhCN from '../esm/zh-cn.mjs';

import allData from './data/all-data.mjs';

import langs from './shared/langs.mjs';

import types from './shared/types.mjs';

import createResult from './shared/create-result.mjs';

import printMsg from './shared/print-msg.mjs';

import processResults from './shared/process-results.mjs';

printMsg('startTest');

// Suppose all testResults are identical
testResults = [];

// Test Numbo
numbo = new Numbo();

for (i = 0, len = langs.length; i < len; i++) {
	lang = langs[i];
	for (j = 0, len1 = types.length; j < len1; j++) {
		type = types[j];
		dataList = allData[lang][type];
		eachTestResult = createResult('numbo', numbo, dataList, lang, type);
		testResults.push(eachTestResult);
	}
}

// Test enUS, zhTW and zhCN
langMods = [
	{
		lang: 'enUS',
		mod: enUS,
	},
	{
		lang: 'zhTW',
		mod: zhTW,
	},
	{
		lang: 'zhCN',
		mod: zhCN,
	},
];

for (k = 0, len2 = langMods.length; k < len2; k++) {
	langMod = langMods[k];
	for (l = 0, len3 = types.length; l < len3; l++) {
		type = types[l];
		dataList = allData[langMod.lang][type];
		eachTestResult = createResult(
			langMod.lang,
			langMod.mod,
			dataList,
			langMod.lang,
			type
		);
		testResults.push(eachTestResult);
	}
}

processResults(testResults);
