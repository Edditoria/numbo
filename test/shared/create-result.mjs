var createSummary, initResult, updateResult;

initResult = function (jobType, dataLen, lang, type) {
	var jobDesc;
	jobDesc =
		jobType === 'numbo'
			? `numbo.convert(input, { ${lang}, ${type} })`
			: `${lang}(input, { ${type} })`;
	return {
		jobDesc: jobDesc,
		summary: 'Waiting...',
		total: dataLen,
		success: 0,
		fail: 0,
		failCases: [],
	};
};

updateResult = function (eachData, testResult) {
	if (eachData.ans === eachData.expect) {
		testResult.success++;
	} else {
		testResult.fail++;
		testResult.failCases.push(eachData);
	}
	return testResult;
};

createSummary = function (total, success, fail) {
	return `${total} tests, ${success} success, ${fail} fail`;
};

/**
@param jobType {string} - Either 'numbo', 'enUS', 'zhTW' or 'zhCN'.
@param callbackFn {Object} - Either enUS, zhTW, zhCN or whole numbo object.
                             Don't import numbo-like objects in this file,
                             so this module file can be re-usable.
*/
export default function (jobType, callbackFn, dataList, lang, type) {
	var eachData, i, len, options, testResult;
	testResult = initResult(jobType, dataList.length, lang, type);
	for (i = 0, len = dataList.length; i < len; i++) {
		eachData = dataList[i];
		options = {
			lang: lang,
			type: type,
		};
		// note: eachData has { input, expect }; Now adds { ans }
		// Only numbo object has .convert() method
		eachData.ans =
			jobType === 'numbo'
				? callbackFn.convert(eachData.input, options)
				: callbackFn(eachData.input, options);
		testResult = updateResult(eachData, testResult);
	}
	testResult.summary = createSummary(
		testResult.total,
		testResult.success,
		testResult.fail
	);
	return testResult;
}
