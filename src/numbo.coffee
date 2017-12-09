###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE.md
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
      console.log 'Depreciated: Parse the whole string using adjustDecimal() instead' #todo
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
            console.log 'Error: Option in parseCents() is invalid. Use the default option (Math.ceil)'
            'ceil'
      Math[mathOption](parseInt(str3dp, 10) / 10)
    speakByDigit: (str, n1, separator = ' ') ->
      # match every characters of `str` to `n1[str]` one-by-one
      # the 1st arg should a string contains numbers only (e.g. '000123')
      # return a string (e.g. 'zero zero zero one two three')
      if typeof str is 'string' and str.search(/\D/g) < 0
        output = []
        output.push(n1[+item]) for item in str
        output.join(separator)
      else
        console.log 'Error: Invalid argument of speakByDigit()'
        null
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
    adjustDecimal: (str, type = 'ceil', dp = 2) ->
      # To adjust `input` to `dp` decimal place, e.g. 123.4567 becomes 123.46
      # - `str` should be a string e.g. '123', '123.45'
      # - `type` accepts 'ceil' (default), 'floor' or 'round'
      # - `dp` should be a number between 0 to 4 (default is 2)
      # To avoid errors, do check() and normalize() before adjustDecimal()
      if typeof str isnt 'string' then str = str.toString() # for safety
      dotIndex = str.indexOf('.')
      if dotIndex is -1 then return str
      # check args
      if type isnt 'ceil' and type isnt 'floor' and type isnt 'round'
        type = 'ceil'
        console.log 'Error: type in adjustDecimal() is invalid. Use the default option (Math.ceil)'
      if typeof dp isnt 'number' or dp < 0
        dp = 2
        console.log 'Error: dp in adjustDecimal() is invalid. Use the default option (adjust to 2 decimal place)'
      # functions to carry digits
      parseDec = (dec, type, dp) ->
        # return '.nnnn' or '1'
        dec = '0.' + dec
        # do dec * 100, then Math[type]
        dec = Math[type](+(dec + 'e+' + dp))
        # do dec / 100
        dec = +(dec + 'e-' + dp) # 1 or 0 or 0.nnnn
        if dec is 0 then ''
        else if dec is 1 then '1'
        else (dec + '').replace(/^0/g, '') # '.nnnn'
      carryInt = (int) ->
        len = int.length
        if len < 16
          +int + 1 + ''
        else
          intArr = int.split('')
          index = len
          isCarry = true
          while index and isCarry
            index--
            thisChar = +intArr[index] + 1 + ''
            if thisChar is '10'
              thisChar = '0'
              # isCarry = true
            else
              isCarry = false
            intArr[index] = thisChar
          if isCarry then intArr.unshift('1')
          intArr.join('')
      if type is 'ceil' or type is 'round'
        # dotIndex = str.indexOf('.') is ready for use
        int = str.slice(0, dotIndex)
        dec = str.slice(dotIndex + 1)
        dec = parseDec(dec, type, dp)
        if dec is '1'
          dec = ''
          int = carryInt(int)
        int + dec
      else if type is 'floor'
        int = str.slice(0, dotIndex)
        dec = str.slice(dotIndex, dotIndex + dp + 1)
        if +dec is 0 then dec = ''
        int + dec
      else
        console.log 'Error: Unknown error in tools.adjustDecimal()'
        str

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
