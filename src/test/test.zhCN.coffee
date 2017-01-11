numbo = require './../lib/numbo.js'
numbo.zhCN = require './../lib/numbo.zhCN.js'
testNum = require './testNum.zhCN.js'
testAmount = require './testAmount.zhCN.js'
testCheque = require './testCheque.zhCN.js'

doTest = (testObj, option, job) ->
  # result is an array contains `true` or `false`
  console.log """
    -------
    Start Test Job: #{job}
    -------
  """
  results = for obj in testObj
    input = obj['input']
    output = numbo.zhCN input, option
    expect = obj['expect']
    result = output is expect
    console.log "
      [#{result}]:
      Input of #{input}
      returns \"#{output}\",
      expected \"#{obj['expect']}\"
    "
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

  summary.report = "#{job} Test Results: #{summary.total} tests, #{summary.success} success, #{summary.fail} fail"

  console.log """

    -------
    #{summary.report}
    -------

    """
  summary

testNumResult = doTest testNum, 'number', 'Converting Number'
testAmountResult = doTest testAmount, 'amount', 'Converting Amount'
testChequeResult = doTest testCheque, 'cheque', 'Converting Cheque'


console.log """

=======
Test Summary in test.zhCN.js:
#{testNumResult.report}
#{testAmountResult.report}
#{testChequeResult.report}
=======
"""

console.log """

=== test.js Test Done ===

"""
