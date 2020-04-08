###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.txt
###

import parse99 from './utils/parse-99.coffee'
import trimWhitespace from './utils/trim-whitespace.coffee'
import parseCents from './utils/parse-cents.coffee'
import speakByDigit from './utils/speak-by-digit.coffee'
import check from './utils/check.coffee'
import normalize from './utils.normalize.coffee'
import adjustDecimal from './utils/adjust-decimal.coffee'
import splitNum from './utils/split-num.coffee'
import splitInt from './utils/split-int.coffee'

class Numbo


  #
  #   #####              ##
  #     #                 #
  #     #     ##    ##    #     ###
  #     #    #  #  #  #   #    #
  #     #    #  #  #  #   #     ##
  #     #    #  #  #  #   #       #
  #     #     ##    ##   ###   ###
  #
  #

  tools =
    parse99: parse99
    trimWhitespace: trimWhitespace
    parseCents: parseCents
    speakByDigit: speakByDigit
    check: check
    normalize: normalize
    adjustDecimal: adjustDecimal
    splitNum: splitNum
    splitInt: splitInt
  tools:
    trimWhitespace: tools.trimWhitespace
    parse99: tools.parse99
    parseCent: tools.parseCents #todo to be depreciated
    parseCents: tools.parseCents #todo to be depreciated
    speakByDigit: tools.speakByDigit
    check: tools.check
    validate: tools.check
    normalize: tools.normalize
    normalise: tools.normalize
    adjustDecimal: tools.adjustDecimal
    splitNum: tools.splitNum
    splitInt: tools.splitInt


  #
  #                #  #   ##
  #                #  #  #  #
  #     ##   ###   #  #  #
  #    #  #  #  #  #  #   ##
  #    ####  #  #  #  #     #
  #    #     #  #  #  #  #  #
  #     ##   #  #   ##    ##
  #
  #

  convert_enUS = (input, options = 'default', zeroCent = false) ->
    # input floating `input` e.g. nnnnnnn.dddd
    # return string e.g. one hundred point two three
    #todo: zeroCent is a temp variable that will be replaced

    n1 = [
      '' #zero
      'One', 'Two', 'Three', 'Four', 'Five'
      'Six', 'Seven', 'Eight', 'Nine', 'Ten'
      'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen'
      'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
    ]
    n1withZero = [
      'Zero'
      'One', 'Two', 'Three', 'Four', 'Five'
      'Six', 'Seven', 'Eight', 'Nine', 'Ten'
      'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen'
      'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
    ]
    n10 = [
      '' #zero
      'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty'
      'Sixty', 'Seventy', 'Eighty', 'Ninety'
    ]
    n1000 = [
      '', 'Thousand', 'Million', 'Billion', 'Trillion'
      'Quadrillion', 'Quintillion', 'Sextillion', 'Septillion', 'Octillion'
      'Nonillion', 'Decillion', 'Undecillion', 'Duodecillion', 'Tredecillion'
      'Quattuordecillion', 'Quindecillion', 'Sexdecillion', 'Septendecillion', 'Octodecillion'
      'Novemdecillion', 'Vigintillion'
    ]

    # n99 is an array ['', One', 'Two'..'Ninety-nine']
    n99 = tools.parse99(n1, n10, '-')

    speak999 = (num, addAnd = true) ->
      # expect `num` is an integer from 1 to 999
      if num <=99 then n99[num]
      else if num % 100 is 0
        n1[Math.floor(num/100)] + ' Hundred'
      else
        d100 = Math.floor(num/100)
        hundred = if addAnd then ' Hundred and ' else ' Hundred '
        output = n1[d100] + hundred + n99[num % 100]

    speakInt = (numArr, addAnd = true) ->
      # expect `numArr` is an array
      output = []
      times = numArr.length
      for item, num in numArr
        times--
        if item isnt '000'
          unit = ' ' + n1000[times]
          item = speak999(parseInt(item, 10), addAnd)
          output.push item + unit
      output.join(' ').replace(/^\s+|\s+$/g,'') # trim whitespace

    #
    #    #  #         #
    #    ####
    #    ####   ###  ##    ###
    #    #  #  #  #   #    #  #
    #    #  #  #  #   #    #  #
    #    #  #  # ##   #    #  #
    #    #  #   # #  ###   #  #
    #
    #

    speakNum = (str) ->
      # convert number `str` to written text
      if str is '0' then 'zero'
      else if str is '1' then 'one' # faster
      else
        strSplited = tools.splitNum(str)
        intArr = tools.splitInt(strSplited[0])
        int = speakInt(intArr)
        if int is '' then int = 'zero'
        dec =
          if strSplited[1] is '' then ''
          else ' point ' + tools.speakByDigit(strSplited[1], n1withZero, ' ')
        (int + dec).toLowerCase()

    speakAmt = (str, options = 'amount', zeroCent) ->
      # convert amount `str` to written text
      # accept options as 'amount' or 'cheque'
      # - amount: some dollars and some cents
      # - cheque: Some Dollars and Some Cents Only
      if str is '0' then output = 'Null'
      else
        dollarUnit = ['Dollar', 'Dollars']
        centUnit = ['Cent', 'Cents']
        # Math.ceil to 2 decimal place
        str = tools.adjustDecimal(str, 'ceil', 2)
        # parse the `str`
        strSplited = tools.splitNum(str)
        # parse dollars
        intArr = tools.splitInt(strSplited[0])
        int = speakInt(intArr, false) # no 'and'
        dollars =
          if int is '' then ''
          else if int is 'One' then ' ' + dollarUnit[0]
          else ' ' + dollarUnit[1]
        # parse cents
        dec = +((strSplited[1] + '0').slice(0,2)) #todo: pack into tools.parseCents
        dec = n99[dec] # remark: n99[0] returns ''
        cents =
          if dec is '' and int is '' then 'Null'
          else if dec is '' then 'No Cent'
          else if dec is 'One' then ' Cent'
          else ' Cents'
        # put together
        andWord =
          if dollars is '' then ''
          else ' and '
        output = int + dollars + andWord + dec + cents
      # adjust the output according to `options`
      output =
        if options is 'cheque'
          if output is 'Null'
            'Null'
          else
            output + ' Only'
        else if options is 'amount'
          output
            .replace(' and No Cent', '')
            .toLowerCase()
        else
          console.log 'Error: Option in speakAmt() is invalid.'
          output = null
      if zeroCent is true then output = output.replace('and No Cent', 'and Zero Cent')
      output

    main = (input, options = 'default', zeroCent = false) ->
      # `input` is a string or number
      # `options` should be a string
      if input is '' then null
      else if input is '1e+100' then 'Ding! One Google... Oops... One Googol!!'
      else
        if tools.check(input) is false
          console.log 'Error: Invalid input value. Return null'
          null
        else
          input = tools.normalize(input) # input must become a string
          #todo: if typeof options is 'string'
          switch options
            when 'default', 'number', 'num' then speakNum(input)
            when 'cheque', 'check', 'chk', 'chq' then speakAmt(input, 'cheque', zeroCent)
            when 'amount', 'amt' then speakAmt(input, 'amount')
            else
              console.log 'Error: Option in enUS is not valid'
              null
    main(input, options, zeroCent)

  enUS: convert_enUS


  #   #####
  #  #     #  ####  #    # #    # ###### #####  #####
  #  #       #    # ##   # #    # #      #    #   #
  #  #       #    # # #  # #    # #####  #    #   #
  #  #       #    # #  # # #    # #      #####    #
  #  #     # #    # #   ##  #  #  #      #   #    #
  #   #####   ####  #    #   ##   ###### #    #   #


  convert: (input, options...) ->
    # `input` can be string or number
    # `options` can be language ('zhTW') and style ('number', 'amount' or 'cheque')
    if options.length is 0 # not provide any option
      convert_enUS(input)
    else
      plugin = '' # set as empty first
      template = '' # set as empty first
      zeroCent = false #todo: temp setup
      otherOptions = []
      error = false
      # parse each item
      for item in options
        if typeof item is 'string'
          if @[item]? # the item is a language/plugin
            if plugin is '' then plugin = item
            else
              console.log 'Error: Invalid option. You have selected more than one language/plugin. Returns null'
              error = true
          else if template is ''
            switch item
              when 'default' then template = 'default'
              when 'number', 'num' then template = 'number'
              when 'check', 'cheque', 'chk', 'chq' then template = 'cheque'
              when 'amount', 'amt' then template = 'amount'
              else
                otherOptions.push(item)
          else
            otherOptions.push(item)
        else # item isnt 'string'
          console.log 'Error: Invalid option. Each option has to be a string.'
          error = true
      # Skip and return null if any error occurs
      if error is true then null
      # Currently, otherOptions is not allowed yet.
      else if otherOptions.length > 0 and otherOptions.toString() isnt 'zeroCent'
        #todo: the condition about 'zeroCent' should be done in parseOption()
        console.log 'Error: Invalid option. Possibly more than one template is selected. Or, some option(s) are parsed into [otherOptions], but it is not allowed in current version yet.'
        null
      else
        # execute convert() according to options provided
        if template is '' then template = 'default'
        if plugin is '' then plugin = 'enUS'
        if otherOptions.toString() is 'zeroCent'
          #todo: should be done in parseOption()
          zeroCent = true
        @[plugin](input, template, zeroCent) #todo: temp setup for zeroCent


numbo = new Numbo()


if module? and module.exports
  module.exports = numbo
if window?
  window.numbo = numbo
