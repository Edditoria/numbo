langs = ['enUS', 'zhCN', 'zhTW']
tpls = ['number', 'amount', 'cheque']

numbo = require './../lib/numbo.js'
numbo.zhTW = require './../lib/numbo.zhTW.js'
numbo.zhCN = require './../lib/numbo.zhCN.js'

testData =
  enUS:
    number: require './testNum.js'
    amount: require './testAmount.js'
    cheque: require './testCheque.js'
  zhCN:
    number: require './testNum.zhCN.js'
    amount: require './testAmount.zhCN.js'
    cheque: require './testCheque.zhCN.js'
  zhTW:
    number: require './testNum.zhTW.js'
    amount: require './testAmount.zhTW.js'
    cheque: require './testCheque.zhTW.js'

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
  Starting Test:
  =============

  Expected error logs and test result:
  """

results = []
for lang in langs
  for tpl in tpls
    jobDesc = "numbo.convert(input, '#{lang}', '#{tpl}')"
    result = doTest testData[lang][tpl], lang, tpl, jobDesc
    results.push result
#todo: doTest for 'default' and option not provided

console.log """

=======
Test Summary in test.js:
"""

for result in results
  console.log result.report

console.log """

=== test.js Test Done ===

"""
