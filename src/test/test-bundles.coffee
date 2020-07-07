###
Run tests for each module: numbo, enUS, zhCN, zhTW.

#todo: Re-write in format of test-esm.coffee and build using rollup.config.js

###

numbo = require '../bundles/numbo.js'
enUS = require '../bundles/numbo.en-us.js'
zhTW = require '../bundles/numbo.zh-tw.js'
zhCN = require '../bundles/numbo.zh-cn.js'

console.log numbo.convert('123.45', 'enUS', 'cheque')
console.log enUS('123.45', 'number')
console.log zhTW('123.45', 'number')
console.log zhCN('123.45', 'number')
