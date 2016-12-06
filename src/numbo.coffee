###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE
###


class Numbo


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
      # `separator`: usually a space ' ' (default), a dash '-', or an empty string ''
      lenArr1 = arr1.length
      for num in [0..99]
        if num < lenArr1
          arr1[num]
        else if num % 10 is 0
          arr10[Math.floor(num/10)]
        else
          arr10[Math.floor(num/10)] + separator + arr1[num % 10].toLowerCase()
    check: (input, characters = '') ->
      # check if there are only:
      # - contains numbers and comma
      # - beginning with any of '$', '+', '-'
      # - only one dot
      # - no ',' after dot
      # accepts additional characters as 2nd argument #todo
      # returns true or false
      #todo
    normalize: (input, characters = '') ->
      # expect `input` is a string of integer or floating
      # features:
      # - remove leading '$', '+' and '-'
      # - remove leading and tailing zero
      # - remove any ',' before '.'
      # - add '0' if the input starts by '.' e.g. '.5'
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
      output
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
    #todo check: tools.check
    normalize: tools.normalize
    normalise: tools.normalize
    splitNum: tools.splitNum
    splitInt: tools.splitInt


  convert_enUS = (input) ->
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
      '', 'Thousand', 'Million', 'Billion', 'Trillion', 'Quadrillion', 'Quintillion'
    'Sextillion', 'Septillion', 'Octillion'
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

    speakInt = (numArr) ->
      # expect `numArr` is an array
      output = []
      times = numArr.length
      for item, num in numArr
        times--
        if item isnt '000'
          unit = ' ' + n1000[times]
          item = speak999 parseInt(item, 10)
          output.push item + unit
      output.join(' ').replace(/^\s+|\s+$/g,'') # trim whitespace

    speakDec = (str) ->
      # speak the decimal place one by one
      if str is '' then ''
      else
        strArr = for item in str
          n1withZero[parseInt item, 10]
        ' point ' + strArr.join(' ')

    speakNum = (str) ->
      if str is '0' then 'zero'
      else if str is '1' then 'one'
      else
        strSplited = tools.splitNum(str)
        intArr = tools.splitInt(strSplited[0])
        int = speakInt(intArr)
        if int is '' then int = 'zero'
        dec = speakDec(strSplited[1])
        int + dec

    if input is '' then null
    else if input is '1e+100' then 'Ding! One Google... Oops... One Googol!!'
    else
      if typeof input isnt 'string' then input = input.toString()
      #todo: if tools.check(input) is false .....
      input = tools.normalize(input)
      speakNum(input).toLowerCase()

  enUS: convert_enUS

  convert: (num, options = 'enUS') ->
    @[options](num)


numbo = new Numbo()


if module? and module.exports
  module.exports = numbo
if window?
  window.numbo = numbo
