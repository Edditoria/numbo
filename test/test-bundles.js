/*
Run tests for each bundle: Numbo, enUS, zhCN, zhTW.
This file and required modules are managed by Rollup, not Gulp.
Rollup creates the required files, rather than bundling them in one file.
*/

let dataList, eachTestResult, lang, type;
const Numbo = require('../bundles/numbo.min.js');
const enUS = require('../bundles/numbo.en-us.min.js');
const zhTW = require('../bundles/numbo.zh-tw.min.js');
const zhCN = require('../bundles/numbo.zh-cn.min.js');

/** @type {Data} See data structure in all-data.mjs */
const allData = require('./data/all-data.js');
// Require all-tools instead of one-by-one,
// because rollup packs all tools into one single file.
const tools = require('./shared/all-tools.js');

const {
    langs
} = tools;
const {
    types
} = tools;
const {
    createResult
} = tools;
const {
    printMsg
} = tools;
const {
    processResults
} = tools;

printMsg('startTest');

// Suppose all testResults are identical
const testResults = [];

// Test Numbo

const numbo = new Numbo();

for (lang of langs) {
	for (type of types) {
		dataList = allData[lang][type];
		eachTestResult = createResult(
			'numbo', numbo, dataList, lang, type
		);
		testResults.push(eachTestResult);
	}
}

// Test enUS, zhTW and zhCN

const langMods = [
	{ lang: 'enUS', mod: enUS },
	{ lang: 'zhTW', mod: zhTW },
	{ lang: 'zhCN', mod: zhCN }
];
for (var langMod of langMods) {
	for (type of types) {
		dataList = allData[langMod.lang][type];
		eachTestResult = createResult(
			langMod.lang, langMod.mod, dataList, langMod.lang, type
		);
		testResults.push(eachTestResult);
	}
}

processResults(testResults);
