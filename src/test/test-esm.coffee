###
Run tests for each module: Numbo, enUS, zhCN, zhTW.
This file and the imported modules are managed by Gulp, not Rollup.
Gulp creates all imported files, rather than transpile them into one file.
###

import Numbo from '../esm/index.mjs'
import enUS from '../esm/en-us.mjs'
import zhTW from '../esm/zh-tw.mjs'
import zhCN from '../esm/zh-cn.mjs'

###* @type {Data} See data structure in all-data.coffee ###
import allData from './data/all-data.coffee'
import langs from './shared/langs.coffee'
import types from './shared/types.coffee'
import createResult from './shared/create-result.coffee'
import printMsg from './shared/print-msg.coffee'
import processResults from './shared/process-results.coffee'

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
