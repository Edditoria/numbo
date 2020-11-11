###
Run tests for each bundle: Numbo, enUS, zhCN, zhTW.
This file and required modules are managed by Rollup, not Gulp.
Rollup creates the required files, rather than bundling them in one file.
###

Numbo = require '../bundles/numbo.min.js'
enUS = require '../bundles/numbo.en-us.min.js'
zhTW = require '../bundles/numbo.zh-tw.min.js'
zhCN = require '../bundles/numbo.zh-cn.min.js'

###* @type {Data} See data structure in all-data.coffee ###
allData = require './data/all-data.js'
# Require all-tools instead of one-by-one,
# because rollup packs all tools into one single file.
tools = require './shared/all-tools.js'

langs = tools.langs
types = tools.types
createResult = tools.createResult
printMsg = tools.printMsg
processResults = tools.processResults

printMsg('startTest')

# Suppose all testResults are identical
testResults = []

# Test Numbo

numbo = new Numbo()

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
