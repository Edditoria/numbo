###
Run tests for each module: numbo, enUS, zhCN, zhTW.

#todo: Re-write in format of test-esm.coffee and build using rollup.config.js

###

allData = require './data/all-data.js'
numbo = require '../bundles/numbo.min.js'
enUS = require '../bundles/numbo.en-us.min.js'
zhTW = require '../bundles/numbo.zh-tw.min.js'
zhCN = require '../bundles/numbo.zh-cn.min.js'

console.log numbo.convert('123.45', 'enUS', 'cheque')
console.log enUS('123.45', 'number')
console.log zhTW('123.45', 'number')
console.log zhCN('123.45', 'number')

console.log allData.enUS.amount[3]
