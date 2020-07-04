initResult = (jobType, dataLen, lang, type) ->
	jobDesc =
		if jobType is 'numbo' then "numbo.convert(input, '#{lang}', '#{type}')"
		else "#{lang}(input, '#{type}')"
	return {
		jobDesc: jobDesc
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
@param jobType {string} - Either 'numbo', 'enUS', 'zhTW' or 'zhCN'.
@param callbackFn {Object} - Either enUS, zhTW, zhCN or whole numbo object.
                             Don't import numbo-like objects in this file,
                             so this module file can be re-usable.
###
export default (jobType, callbackFn, dataList, lang, type) ->
	testResult = initResult(jobType, dataList.length, lang, type)
	for eachData in dataList
		# note: eachData has { input, expect }; Now adds { ans }
		eachData.ans =
			if jobType is 'numbo'
				# Only numbo object has .convert() method
				callbackFn.convert(eachData.input, lang, type)
			else
				callbackFn(eachData.input, type)
		testResult = updateResult(eachData, testResult)
	testResult.summary = createSummary(
		testResult.total
		testResult.success
		testResult.fail
	)
	return testResult
