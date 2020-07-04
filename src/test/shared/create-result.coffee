initResult = (desc, dataLen, lang, type) ->
	return {
		jobDesc: "#{desc}(input, '#{lang}', '#{type}')"
		summary: 'Waiting...'
		total: dataLen
		success: 0
		fail: 0
		failCases: []
	}
updateResult = (eachData, testResult) ->
	if eachData.ans is eachData.expect
		testResult.success++
	else
		testResult.fail++
		testResult.failCases.push eachData
	return testResult

createSummary = (total, success, fail) ->
	return "#{total} tests, #{success} success, #{fail} fail"

###*
@param callbackFn {Object} - Either enUS, zhTW, zhCN or whole numbo object.
	Don't import numbo stuff in this file, so this module file can be re-usable.
###
export default (desc, callbackFn, dataList, lang, type) ->
	testResult = initResult(desc, dataList.length, lang, type)
	for eachData in dataList
		# note: eachData has { input, expect }; Now adds { ans }
		eachData.ans = callbackFn.convert(eachData.input, lang, type)
		testResult = updateResult(eachData, testResult)
	testResult.summary = createSummary(
		testResult.total
		testResult.success
		testResult.fail
	)
	return testResult
