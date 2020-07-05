import printMsg from './print-msg.coffee'

export default (testResults) ->
	total = 0
	success = 0
	fail = 0
	failCasesList = []

	printMsg('summary')

	for result in testResults
		total += result.total
		success += result.success
		fail += result.fail
		if result.failCases.length > 0
			failCasesList.push {
				jobDesc: result.jobDesc
				failCases: result.failCases
			}
		console.log "#{result.jobDesc}: #{result.summary}"

	if failCasesList.length > 0
		printMsg('failResults')
		for eachFailCases in failCasesList
			console.log "-> #{eachFailCases.jobDesc}"
			console.log eachFailCases.failCases
			console.log '\n'

	printMsg('testDone')

	console.log "Total: #{total}; Success: #{success}; Fail: #{fail}"
	return
