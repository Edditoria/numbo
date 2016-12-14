###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE
###


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
    trimWhitespace: (str) ->
      str.replace(/^\s+|\s+$/g,'')
    parse99: (arr1, arr10, separator = ' ') ->
      # parse number to words from 0 to 99
      # 0 is usually an empty string ''
      # `arr1`: array from 0 to 9 in a language
      #   e.g. ['', One', 'Two',...'Nine']
      # `arr10`: unit [10, 20, 30,...90] in a language
      #   e.g. ['Ten', 'Twenty',...'Ninety']
      # output example: ['One', 'Two',...'Ninty-nine']
      # `separator`: usually a space ' ' (default), a hyphen '-', or an empty string ''
      lenArr1 = arr1.length
      for num in [0..99]
        if num < lenArr1
          arr1[num]
        else if num % 10 is 0
          arr10[Math.floor(num/10)]
        else
          arr10[Math.floor(num/10)] + separator + arr1[num % 10].toLowerCase()
    parseCents: (str, option = 'ceil') ->
      # slice first 3 characters, round it, then return 2-digit number
      # e.g. '015' becomes '02' (2 cents), '5' becomes '50' (50 cents)
      # `option` supports 'ceil', 'round', 'floor'
      str3dp = (str + '000').slice(0,3)
      mathOption =
        switch option
          when 'round' then 'round'
          when 'floor' then 'floor'
          when 'ceil' then 'ceil'
          else
            console.log 'Error: option in parseCents() is invalid. Use the default option (Math.ceil)'
            'ceil'
      Math[mathOption](parseInt(str3dp, 10) / 10)
    check: (input, characters = '') ->
      # check if there are only:
      # - contains numbers and comma
      # - beginning with any of '$', '+', '-'
      # - only one dot
      # - no ',' after dot
      # accepts additional characters as 2nd argument #todo
      # returns true or false
      result = false
      inputStr = input.toString()
      acceptRegex = /^[\+\-\$]*[\d\.\,]*|[\d\.\,]*/g
      illegalStr = inputStr.replace(acceptRegex, '')
      dotCount = (inputStr.match(/\./g) or []).length # count string occurrence in string
      commaAfterDot = inputStr.indexOf(',', inputStr.indexOf('.')) > 0
      if illegalStr is '' and dotCount < 2 and !commaAfterDot then result = true
      result
    normalize: (input, characters = '') ->
      # expect `input` is a string of integer or floating
      # features:
      # - remove leading '$', '+' and '-'
      # - remove leading and tailing zero
      # - remove any ',' before '.'
      # - add '0' if the input starts by '.' e.g. '.5'
      # remove '.' if no decimal place
      # accepts additional characters as 2nd argument #todo
      if typeof input isnt 'string' then input = input.toString() # for safety
      regexHead = /,|^[$|\-]*(0|,)*(?!\.)/g # e.g. '-$0,001,000' matches '$0,00'
      regexTail = /0*$/g
      dotIndex = input.indexOf('.')
      if dotIndex is -1
        output = input.replace(regexHead, '')
      else
        inputArr = tools.splitNum(input)
        inputArr[0] = inputArr[0].replace(regexHead, '')
        inputArr[1] = inputArr[1].replace(regexTail, '')
        output = inputArr.join('.')
      # if output is an empty string or begins with '.', add a '0'
      if output.indexOf('.') is 0 then output = '0' + output
      if output is '' then output = '0'
      # if output is end with '.', remove the '.'
      output.replace(/\.$/, '')
    splitNum: (input) ->
      # `input` should be a string or number of positive number (integer or float), e.g. 'nnnnnnnn.dddd'
      # return an array ['nnnnnnnn', 'dddd']
      # if there is no decimal place, will return ['nnnn', '']
      if typeof input isnt 'string' then input = input.toString() # for safety
      if input.indexOf('.') is -1
        output = [input, '']
      else
        output = input.split('.')
      if output[0] is '' then output[0] = '0'
      output
    splitInt: (int, digit = 3) ->
      # split `int` (an integer) into ['n', 'nnn', 'nnn'...], depends on `digit`
      if typeof int isnt 'string' then int = int.toString() # for safety
      output = []
      times = Math.ceil(int.length / digit) # at least 1
      while times
        len = int.length
        intTail = int.substring(len-digit, len) # cut the tail
        int = int.substring(0, len-digit) # the remaining `int`
        output.unshift(intTail)
        times--
      output
  tools:
    trimWhitespace: tools.trimWhitespace
    parse99: tools.parse99
    parseCent: tools.parseCents
    parseCents: tools.parseCents
    check: tools.check
    validate: tools.check
    normalize: tools.normalize
    normalise: tools.normalize
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

  convert_enUS = (input, options = 'default') ->
    # input floating `input` e.g. nnnnnnn.dddd
    # return string e.g. one hundred point two three

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

    speakDec = (str) ->
      # speak the decimal place one by one
      if str is '' then ''
      else
        strArr = for item in str
          n1withZero[parseInt item, 10]
        ' point ' + strArr.join(' ')

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
        dec = speakDec(strSplited[1])
        (int + dec).toLowerCase()

    speakAmt = (str, options = 'amount') ->
      # convert amount `str` to written text
      # accept options as 'amount' or 'cheque'
      # - amount: some dollars and some cents
      # - cheque: Some Dollars and Some Cents Only
      if str is '0' then output = 'Null'
      else
        dollarUnit = ['Dollar', 'Dollars']
        centUnit = ['Cent', 'Cents']
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
        dec = n99[tools.parseCents(strSplited[1])] # remark: n99[0] returns ''
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
          console.log 'Error: option in speakAmt is invalid.'
          output = null
      output

    main = (input, options) ->
      # `input` is a string or number
      # `options` should be a string
      if input is '' then null
      else if input is '1e+100' then 'Ding! One Google... Oops... One Googol!!'
      else
        #todo: if tools.check(input) is false .....
        input = tools.normalize(input) # input must become a string
        #todo: if typeof options is 'string'
        switch options
          when 'default', 'number' then speakNum(input)
          when 'cheque', 'check' then speakAmt(input, 'cheque')
          when 'amount', 'amt' then speakAmt(input, 'amount')
          else
            console.log 'option in enUS is not valid'
            null
    main(input, options)

  enUS: convert_enUS


  convert: (num, options = 'default') ->
    # `num` can be string or number
    # `options` can be 'number', 'amount' or 'cheque'
    if options is 'default'
      convert_enUS(num) # faster
    else if typeof options is 'string'
      # One single option is provded
      # e.g. 'zhTW', 'amount', 'cheque', etc.
      if @[options]?
        # accept language plugin e.g. 'zhTW' refers to convert_zhTW
        @[options](num)
      else
        # not a lang, and refer to options in enUS, e.g. 'cheque', 'amount'
        convert_enUS(num, options)
    else if Object.prototype.toString.call(options) is '[object Object]'
      console.log 'Error: Invalid option. Option does not supports object yet. Returns null' #todo
      null
    else
      console.log 'Error: Invalid option. Option should be a string or an object. Returns null'
      null


numbo = new Numbo()


if module? and module.exports
  module.exports = numbo
if window?
  window.numbo = numbo
