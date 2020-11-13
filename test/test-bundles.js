'use strict';

/*
Run tests for each bundle: Numbo, enUS, zhCN, zhTW.
This file and required modules are managed by Rollup, not Gulp.
Rollup creates the required files, rather than bundling them in one file.
*/
/** @type {Data} See data structure in all-data.coffee */
var Numbo, allData, createResult, dataList, eachTestResult, enUS, i, j, k, l, lang, langMod, langMods, langs, len, len1, len2, len3, numbo, printMsg, processResults, testResults, tools, type, types, zhCN, zhTW;

Numbo = require('../bundles/numbo.min.js');

enUS = require('../bundles/numbo.en-us.min.js');

zhTW = require('../bundles/numbo.zh-tw.min.js');

zhCN = require('../bundles/numbo.zh-cn.min.js');

allData = require('./data/all-data.js');

// Require all-tools instead of one-by-one,
// because rollup packs all tools into one single file.
tools = require('./shared/all-tools.js');

langs = tools.langs;

types = tools.types;

createResult = tools.createResult;

printMsg = tools.printMsg;

processResults = tools.processResults;

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
    mod: enUS
  },
  {
    lang: 'zhTW',
    mod: zhTW
  },
  {
    lang: 'zhCN',
    mod: zhCN
  }
];

for (k = 0, len2 = langMods.length; k < len2; k++) {
  langMod = langMods[k];
  for (l = 0, len3 = types.length; l < len3; l++) {
    type = types[l];
    dataList = allData[langMod.lang][type];
    eachTestResult = createResult(langMod.lang, langMod.mod, dataList, langMod.lang, type);
    testResults.push(eachTestResult);
  }
}

processResults(testResults);
