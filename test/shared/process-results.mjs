import printMsg from './print-msg.mjs';

export default function (testResults) {
	var eachFailCases,
		fail,
		failCasesList,
		i,
		j,
		len,
		len1,
		result,
		success,
		total;
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
				failCases: result.failCases,
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
