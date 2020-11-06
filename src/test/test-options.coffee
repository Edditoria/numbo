import Numbo from '../esm/index.mjs'
import printMsg from './shared/print-msg.coffee'

numbo = new Numbo()
input = '10'
defaultOptions = numbo.getDefaultOptions()

# Simple version of node.util.isDeepStrictEqual()
compareEqObject = (obj1, obj2) ->
	keys1 = Object.keys(obj1)
	keys2 = Object.keys(obj2)
	if keys1.length isnt keys2.length
		return false
	# else if
	for eachKey in keys1
		if obj1[eachKey] isnt obj2[eachKey]
			return false
	# else
	return true


# Results of getOptions() should remain unchanged
dataWhenConvert = [
	{
		options: null
		expectOutput: 'ten'
	}, {
		options: { lang: 'zhTW', type: 'amount' }
		expectOutput: '十元'
	}, {
		options: { lang: 'zhCN' }
		expectOutput: '十'
	}, {
		options: { lang: 'enUS', type: 'cheque' }
		expectOutput: 'Ten Dollars and No Cent Only'
	}, {
		options: { type: 'cheque', zeroCent: true }
		expectOutput: 'Ten Dollars and Zero Cent Only'
	}, {
		options: { lang: 'enUS', type: 'cheque' }
		expectOutput: 'Ten Dollars and No Cent Only'
	}, {
		options: { lang: 'zhTW', type: 'check' }
		expectOutput: '拾元正'
	}
]

# Results of getOptions() will change step-by-step
dataWhenSetOptions = [
	{
		options: null
		expectGetOptions: { lang: 'enUS', type: 'number' }
	}, {
		options: { type: 'cheque' }
		expectGetOptions: { lang: 'enUS', type: 'cheque' }
	}, {
		options: { lang: 'zhTW' }
		expectGetOptions: { lang: 'zhTW', type: 'cheque' }
	}, {
		options: { lang: 'enUS', zeroCent: true }
		expectGetOptions: { lang: 'enUS', type: 'cheque', zeroCent: true }
	}
]

console.log 'Mini-test: Get/Set Options'
console.log '=========================='

failResults = []

# Test: .getOptions() during .convert()
for eachData in dataWhenConvert
	output = numbo.convert(input, eachData.options)
	isEqOutput = output is eachData.expectOutput
	isEqOptions = compareEqObject(numbo.getOptions(), defaultOptions)
	if !isEqOutput or !isEqOptions
		failResults.push({
			desc: 'Unexpected .getOptions() during .convert()'
			inputOptions: eachData.options
			expectOutput: eachData.expectOutput
			output: output
			isEqOutput: isEqOutput
			isEqOptions: isEqOptions
		})

# Test: .getOptions() during .setOptions()
for eachData in dataWhenSetOptions
	numbo.setOptions(eachData.options)
	isEqOptions = compareEqObject(eachData.expectGetOptions, numbo.getOptions())
	if !isEqOptions
		failResults.push({
			desc: 'Unexpected .getOptions() during .setOptions()'
			inputOptions: eachData.options
			expectGetOptions: eachData.expectGetOptions
			isEqOptions: isEqOptions
		})

if failResults.length > 0
	printMsg 'failResults'
	console.log failResults
	throw new Error('test-options')
else
	printMsg 'testDone'
	console.log 'No error found in get/set options()'
	console.log ''
