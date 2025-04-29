/*
Run tests for each module: Numbo, enUS, zhCN, zhTW.
This file and the imported modules are managed by Gulp, not Rollup.
Gulp creates all imported files, rather than transpile them into one file.
*/

let dataList, eachTestResult, lang, type;
import Numbo from '../esm/index.mjs';
import enUS from '../esm/en-us.mjs';
import zhTW from '../esm/zh-tw.mjs';
import zhCN from '../esm/zh-cn.mjs';

/** @type {Data} See data structure in all-data.mjs */
import allData from './data/all-data.mjs';
import langs from './shared/langs.mjs';
import types from './shared/types.mjs';
import createResult from './shared/create-result.mjs';
import printMsg from './shared/print-msg.mjs';
import processResults from './shared/process-results.mjs';

printMsg('startTest');

// Suppose all testResults are identical
const testResults = [];

// Test Numbo

const numbo = new Numbo();

for (lang of langs) {
	for (type of types) {
		dataList = allData[lang][type];
		eachTestResult = createResult('numbo', numbo, dataList, lang, type);
		testResults.push(eachTestResult);
	}
}

// Test enUS, zhTW and zhCN

const langMods = [
	{ lang: 'enUS', mod: enUS },
	{ lang: 'zhTW', mod: zhTW },
	{ lang: 'zhCN', mod: zhCN },
];
for (var langMod of langMods) {
	for (type of types) {
		dataList = allData[langMod.lang][type];
		eachTestResult = createResult(langMod.lang, langMod.mod, dataList, langMod.lang, type);
		testResults.push(eachTestResult);
	}
}

processResults(testResults);
