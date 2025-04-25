import printMsg from './print-msg.mjs';

export default (function(testResults) {
	let total = 0;
	let success = 0;
	let fail = 0;
	const failCasesList = [];

	printMsg('summary');

	for (var result of testResults) {
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
		for (var eachFailCases of failCasesList) {
			console.log(`-> ${eachFailCases.jobDesc}`);
			console.log(eachFailCases.failCases);
			console.log('\n');
		}
	}

	printMsg('testDone');

	console.log(`Total: ${total}; Success: ${success}; Fail: ${fail}`);
});
