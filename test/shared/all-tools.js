'use strict';

var langs = ['enUS', 'zhTW', 'zhCN'];

var types = ['amount', 'number', 'cheque'];

var createSummary, initResult, updateResult;

initResult = function(jobType, dataLen, lang, type) {
  var jobDesc;
  jobDesc = jobType === 'numbo' ? `numbo.convert(input, { ${lang}, ${type} })` : `${lang}(input, { ${type} })`;
  return {
    jobDesc: jobDesc,
    summary: 'Waiting...',
    total: dataLen,
    success: 0,
    fail: 0,
    failCases: []
  };
};

updateResult = function(eachData, testResult) {
  if (eachData.ans === eachData.expect) {
    testResult.success++;
  } else {
    testResult.fail++;
    testResult.failCases.push(eachData);
  }
  return testResult;
};

createSummary = function(total, success, fail) {
  return `${total} tests, ${success} success, ${fail} fail`;
};

/**
@param jobType {string} - Either 'numbo', 'enUS', 'zhTW' or 'zhCN'.
@param callbackFn {Object} - Either enUS, zhTW, zhCN or whole numbo object.
                             Don't import numbo-like objects in this file,
                             so this module file can be re-usable.
*/
function createResult(jobType, callbackFn, dataList, lang, type) {
  var eachData, i, len, options, testResult;
  testResult = initResult(jobType, dataList.length, lang, type);
  for (i = 0, len = dataList.length; i < len; i++) {
    eachData = dataList[i];
    options = {
      lang: lang,
      type: type
    };
    // note: eachData has { input, expect }; Now adds { ans }
    // Only numbo object has .convert() method
    eachData.ans = jobType === 'numbo' ? callbackFn.convert(eachData.input, options) : callbackFn(eachData.input, options);
    testResult = updateResult(eachData, testResult);
  }
  testResult.summary = createSummary(testResult.total, testResult.success, testResult.fail);
  return testResult;
}

function printMsg(topic) {
  var content;
  content = (function() {
    switch (topic) {
      case 'startTest':
        return `Starting Test
=============

The following error logs may be expected (true negatives):
`;
      case 'summary':
        return `
Summary
=======
`;
      case 'failResults':
        return `
Fail Results
============
`;
      case 'testDone':
        return `
Test Done
=========
`;
    }
  })();
  console.log(content);
}

function processResults(testResults) {
  var eachFailCases, fail, failCasesList, i, j, len, len1, result, success, total;
  total = 0;
  success = 0;
  fail = 0;
  failCasesList = [];
  printMsg('summary');
  for (i = 0, len = testResults.length; i < len; i++) {
    result = testResults[i];
    total += result.total;
    success += result.success;
    fail += result.fail;
    if (result.failCases.length > 0) {
      failCasesList.push({
        jobDesc: result.jobDesc,
        failCases: result.failCases
      });
    }
    console.log(`${result.jobDesc}: ${result.summary}`);
  }
  if (failCasesList.length > 0) {
    printMsg('failResults');
    for (j = 0, len1 = failCasesList.length; j < len1; j++) {
      eachFailCases = failCasesList[j];
      console.log(`-> ${eachFailCases.jobDesc}`);
      console.log(eachFailCases.failCases);
      console.log('\n');
    }
  }
  printMsg('testDone');
  console.log(`Total: ${total}; Success: ${success}; Fail: ${fail}`);
}

var allTools = {
  langs: langs,
  types: types,
  createResult: createResult,
  printMsg: printMsg,
  processResults: processResults
};

module.exports = allTools;
