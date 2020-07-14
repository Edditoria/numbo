###
Run tests for each module: numbo, enUS, zhCN, zhTW.

###

numbo = require '../bundles/numbo.min.js'
enUS = require '../bundles/numbo.en-us.min.js'
zhTW = require '../bundles/numbo.zh-tw.min.js'
zhCN = require '../bundles/numbo.zh-cn.min.js'

allData = require './data/all-data.js'
tools = require './shared/all-tools.js'

langs = tools.langs
types = tools.types
createResult = tools.createResult
printMsg = tools.printMsg
processResults = tools.processResults

printMsg('startTest')

# Suppose all testResults are identical
testResults = []

# Test numbo

for lang in langs
	for type in types
		dataList = allData[lang][type]
		eachTestResult = createResult(
			'numbo', numbo, dataList, lang, type
		)
		testResults.push eachTestResult

# Test enUS, zhTW and zhCN

langMods = [
	{ lang: 'enUS', mod: enUS }
	{ lang: 'zhTW', mod: zhTW }
	{ lang: 'zhCN', mod: zhCN }
]
for langMod in langMods
	for type in types
		dataList = allData[langMod.lang][type]
		eachTestResult = createResult(
			langMod.lang, langMod.mod, dataList, langMod.lang, type
		)
		testResults.push eachTestResult

processResults(testResults)
