let eachData, isEqOptions;
import Numbo from '../esm/index.mjs';
import printMsg from './shared/print-msg.mjs';

const numbo = new Numbo();
const input = '10';
const defaultOptions = numbo.getDefaultOptions();

// Simple version of node.util.isDeepStrictEqual()
const compareEqObject = function (obj1, obj2) {
	const keys1 = Object.keys(obj1);
	const keys2 = Object.keys(obj2);
	if (keys1.length !== keys2.length) {
		return false;
	}
	// else if
	for (var eachKey of keys1) {
		if (obj1[eachKey] !== obj2[eachKey]) {
			return false;
		}
	}
	// else
	return true;
};

// Results of getOptions() should remain unchanged
const dataWhenConvert = [
	{
		options: null,
		expectOutput: 'ten',
	},
	{
		options: { lang: 'zhTW', type: 'amount' },
		expectOutput: '十元',
	},
	{
		options: { lang: 'zhCN' },
		expectOutput: '十',
	},
	{
		options: { lang: 'enUS', type: 'cheque' },
		expectOutput: 'Ten Dollars and No Cent Only',
	},
	{
		options: { type: 'cheque', zeroCent: true },
		expectOutput: 'Ten Dollars and Zero Cent Only',
	},
	{
		options: { lang: 'enUS', type: 'cheque' },
		expectOutput: 'Ten Dollars and No Cent Only',
	},
	{
		options: { lang: 'zhTW', type: 'check' },
		expectOutput: '拾元正',
	},
];

// Results of getOptions() will change step-by-step
const dataWhenSetOptions = [
	{
		options: null,
		expectGetOptions: { lang: 'enUS', type: 'number' },
	},
	{
		options: { type: 'cheque' },
		expectGetOptions: { lang: 'enUS', type: 'cheque' },
	},
	{
		options: { lang: 'zhTW' },
		expectGetOptions: { lang: 'zhTW', type: 'cheque' },
	},
	{
		options: { lang: 'enUS', zeroCent: true },
		expectGetOptions: { lang: 'enUS', type: 'cheque', zeroCent: true },
	},
];

console.log('Mini-test: Get/Set Options');
console.log('==========================');

const failResults = [];

// Test: .getOptions() during .convert()
for (eachData of dataWhenConvert) {
	var output = numbo.convert(input, eachData.options);
	var isEqOutput = output === eachData.expectOutput;
	isEqOptions = compareEqObject(numbo.getOptions(), defaultOptions);
	if (!isEqOutput || !isEqOptions) {
		failResults.push({
			desc: 'Unexpected .getOptions() during .convert()',
			inputOptions: eachData.options,
			expectOutput: eachData.expectOutput,
			output,
			isEqOutput,
			isEqOptions,
		});
	}
}

// Test: .getOptions() during .setOptions()
for (eachData of dataWhenSetOptions) {
	numbo.setOptions(eachData.options);
	isEqOptions = compareEqObject(eachData.expectGetOptions, numbo.getOptions());
	if (!isEqOptions) {
		failResults.push({
			desc: 'Unexpected .getOptions() during .setOptions()',
			inputOptions: eachData.options,
			expectGetOptions: eachData.expectGetOptions,
			isEqOptions,
		});
	}
}

if (failResults.length > 0) {
	printMsg('failResults');
	console.log(failResults);
	throw new Error('test-options');
} else {
	printMsg('testDone');
	console.log('No error found in get/set options()');
	console.log('');
}
