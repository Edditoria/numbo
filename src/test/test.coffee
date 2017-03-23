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

doTest = (testObj, lang, option, job) ->
  # result is an array contains `true` or `false`
  console.log """
    -> numbo.convert(input, #{lang}, #{option}):
  """
  results = for obj in testObj
    input = obj['input']
    output = numbo[lang] input, option
    expect = obj['expect']
    result = output is expect
    # Following logging is sometimes useful
    # console.log "
    #   [#{result}]:
    #   Input of #{input}
    #   returns \"#{output}\",
    #   expected \"#{obj['expect']}\"
    # "
    result

  summary =
    job: job
    total: results.length
    success: 0
    fail: 0
    report: ''

  for item in results
    if item is false then summary.fail++
    else if item is true then summary.success++

  summary.report = "#{job}: #{summary.total} tests, #{summary.success} success, #{summary.fail} fail"

  console.log """
    Result: #{summary.total} tests, #{summary.success} success, #{summary.fail} fail

    """
  summary

console.log """
  Starting Test
  =============

  Error logs (that MAY not make the test fail):

  """

results = []
for lang in langs
  for tpl in tpls
    jobDesc = "numbo.convert(input, '#{lang}', '#{tpl}')"
    result = doTest testData[lang][tpl], lang, tpl, jobDesc
    results.push result
#todo: doTest for 'default' and option not provided

console.log """
  Summary
  =======

"""

for result in results
  console.log result.report

console.log """

=== Test Done ===

"""
