numbo = require './../lib/numbo.js'
numbo.zhTW = require './../lib/numbo.zhTW.js'
numbo.zhCN = require './../lib/numbo.zhCN.js'

langs = ['enUS', 'zhCN', 'zhTW']
tpls = ['number', 'amount', 'cheque']

# create testData object in structure of testData[lang][tpl]
requireTestData = ->
  output = {}
  for lang in langs
    output[lang] = {}
    for tpl in tpls
      output[lang][tpl] = require "./testData.#{lang}.#{tpl}.js"
  output
testData = requireTestData()


console.log """
  Starting Test
  =============

  Error logs (that MAY not make the test fail):

  """

doTest = (testObj, lang, tpl) ->
  # do numbo.convert(input, lang, tpl)
  # return the results with summary and fail objects
  results =
    jobDesc: "numbo.convert(input, '#{lang}', '#{tpl}')"
    summary: ''
    total: testObj.length
    success: 0
    fail: 0
    failObj: []

  console.log """
    -> #{results.jobDesc}:
  """

  for obj in testObj
    output = numbo.convert(obj.input, lang, tpl)
    # note: numbo.convert() may generate errors in console.log, but it may be expected
    result = output is obj.expect
    if result is true
      results.success++
    else
      results.fail++
      obj.output = output
      obj.jobDesc = results.jobDesc
      results.failObj.push(obj)

  results.summary = "#{results.total} tests, #{results.success} success, #{results.fail} fail"
  console.log """
    Result: #{results.summary}

  """
  results

testResults = {summary: [], fail: []}

for lang in langs
  for tpl in tpls
    result = doTest(testData[lang][tpl], lang, tpl)
    testResults.summary.push(result)
    if result.fail > 0
      testResults.fail.push(result.failObj)
#todo: doTest for 'default' and option not provided


console.log """
  Summary
  =======

"""

for result in testResults.summary
  console.log "#{result.jobDesc}: #{result.summary}"

if testResults.fail.length > 0
  console.log """

    Fail Results
    ============

  """
  for item in testResults.fail
    console.log item

console.log """

=== Test Done ===

"""
