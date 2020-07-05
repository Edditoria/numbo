import printMsg from './print-msg.coffee'

export default (testResults) ->
	total = 0
	success = 0
	fail = 0
	failCases = []

	printMsg('summary')

	for result in testResults
		total += result.total
		success += result.success
		fail += result.fail
		if result.failCases.length > 0
			failCases.push result.failCases
		console.log "#{result.jobDesc}: #{result.summary}"

	if failCases.length > 0
		printMsg('failResults')
		console.log failCases

	printMsg('testDone')

	console.log "Total: #{total}; Success: #{success}; Fail: #{fail}"
	return
