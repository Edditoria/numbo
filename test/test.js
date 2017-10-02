// Generated by CoffeeScript 1.12.7
(function() {
  var doTest, i, j, k, lang, langs, len, len1, len2, numbo, ref, requireTestData, result, testData, testResults, tpl, tpls;

  numbo = require('./../lib/numbo.js');

  numbo.zhTW = require('./../lib/numbo.zhTW.js');

  numbo.zhCN = require('./../lib/numbo.zhCN.js');

  langs = ['enUS', 'zhCN', 'zhTW'];

  tpls = ['number', 'amount', 'cheque'];

  requireTestData = function() {
    var i, j, lang, len, len1, output, tpl;
    output = {};
    for (i = 0, len = langs.length; i < len; i++) {
      lang = langs[i];
      output[lang] = {};
      for (j = 0, len1 = tpls.length; j < len1; j++) {
        tpl = tpls[j];
        output[lang][tpl] = require("./testData." + lang + "." + tpl + ".js");
      }
    }
    return output;
  };

  testData = requireTestData();

  console.log("Starting Test\n=============\n\nError logs (that MAY not make the test fail):\n");

  doTest = function(testObj, lang, tpl) {
    var i, len, obj, output, result, results;
    results = {
      jobDesc: "numbo.convert(input, '" + lang + "', '" + tpl + "')",
      summary: '',
      total: testObj.length,
      success: 0,
      fail: 0,
      failObj: []
    };
    console.log("-> " + results.jobDesc + ":");
    for (i = 0, len = testObj.length; i < len; i++) {
      obj = testObj[i];
      output = numbo.convert(obj.input, lang, tpl);
      result = output === obj.expect;
      if (result === true) {
        results.success++;
      } else {
        results.fail++;
        obj.output = output;
        obj.jobDesc = results.jobDesc;
        results.failObj.push(obj);
      }
    }
    results.summary = results.total + " tests, " + results.success + " success, " + results.fail + " fail";
    console.log("Result: " + results.summary + "\n");
    return results;
  };

  testResults = {
    summary: [],
    fail: []
  };

  for (i = 0, len = langs.length; i < len; i++) {
    lang = langs[i];
    for (j = 0, len1 = tpls.length; j < len1; j++) {
      tpl = tpls[j];
      result = doTest(testData[lang][tpl], lang, tpl);
      testResults.summary.push(result);
      if (result.fail > 0) {
        testResults.fail.push(result.failObj);
      }
    }
  }

  console.log("Summary\n=======\n");

  ref = testResults.summary;
  for (k = 0, len2 = ref.length; k < len2; k++) {
    result = ref[k];
    console.log(result.jobDesc + ": " + result.summary);
  }

  if (testResults.fail.length > 0) {
    console.log("\nFail Results\n============\n");
    console.log(testResults.fail);
    console.log('\n');
    if ((typeof module !== "undefined" && module !== null) && module.exports) {
      throw new Error("Test fail. Process exit now.");
    }
  }

  console.log("\n=== Test Done ===");

}).call(this);
