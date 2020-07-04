###
Run tests for each module: numbo, enUS, zhCN, zhTW.
This file is usable after compiling to mjs.
Do not work in Rollup or Babel.
###

###* @type {Data} See data structure in all-data.coffee ###
import allData from './data/all-data.mjs'
import numbo from '../esm/numbo.mjs'

import langs from './shared/langs.coffee'
import types from './shared/types.coffee'
import createResult from './shared/create-result.coffee'

# All eachTestResult are identical
testResults = []

for lang in langs
	for type in types
		dataList = allData[lang][type]
		eachTestResult = createResult(
			'numbo.convert', numbo, dataList, lang, type
		)
		testResults.push eachTestResult

console.log testResults
