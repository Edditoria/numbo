const initResult = function (jobType, dataLen, lang, type) {
	const jobDesc = jobType === 'numbo' ? `numbo.convert(input, { ${lang}, ${type} })` : `${lang}(input, { ${type} })`;
	return {
		jobDesc,
		summary: 'Waiting...',
		total: dataLen,
		success: 0,
		fail: 0,
		failCases: [],
	};
};
const updateResult = function (eachData, testResult) {
	if (eachData.ans === eachData.expect) {
		testResult.success++;
	} else {
		testResult.fail++;
		testResult.failCases.push(eachData);
	}
	return testResult;
};

const createSummary = (total, success, fail) => `${total} tests, ${success} success, ${fail} fail`;

/**
@param jobType {string} - Either 'numbo', 'enUS', 'zhTW' or 'zhCN'.
@param callbackFn {Object} - Either enUS, zhTW, zhCN or whole numbo object.
                             Don't import numbo-like objects in this file,
                             so this module file can be re-usable.
*/
export default (function (jobType, callbackFn, dataList, lang, type) {
	let testResult = initResult(jobType, dataList.length, lang, type);
	for (var eachData of dataList) {
		var options = { lang, type };
		// note: eachData has { input, expect }; Now adds { ans }
		eachData.ans =
			jobType === 'numbo'
				? // Only numbo object has .convert() method
					callbackFn.convert(eachData.input, options)
				: callbackFn(eachData.input, options);
		testResult = updateResult(eachData, testResult);
	}
	testResult.summary = createSummary(testResult.total, testResult.success, testResult.fail);
	return testResult;
});
