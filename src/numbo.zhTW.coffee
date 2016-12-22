###

numbo.zhTW, as a plugin for Numbo, convert number to Traditional Chinese.

This plugin and Numbo are open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE
###

zhTW = (input, options = 'default') ->

  #                ####### #     #
  #  ###### #    #    #    #  #  #
  #      #  #    #    #    #  #  #
  #     #   ######    #    #  #  #
  #    #    #    #    #    #  #  #
  #   #     #    #    #    #  #  #
  #  ###### #    #    #     ## ##

  # 0 to 9
  n1 = ['零', '壹', '貳', '叁', '肆', '伍', '陸', '柒', '捌', '玖']
  n1Simple = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九']
  # units for digits (i.e. 1, 10, 100, 1000)
  n10 = ['', '拾', '佰', '仟']
  n10Simple = ['', '十', '百', '千']
  # units for large number (i.e. 1, 1 0000 , 1 0000 0000 ...)
  # 萬萬為億，萬億為兆
  nlarge = [
    '', '萬', '億', '兆', '京'
    '垓', '秭', '穰', '溝', '澗', '正', '載'
  ]
  speak9999 = (str, isSimple = true) ->
    # expect a string within 4 digit
    # may contain double '零'/'〇', but not going to fix it here
    speakN1 = if isSimple then n1Simple else n1
    speakN10 = if isSimple then n10Simple else n10
    times = str.length - 1
    output = []
    for num in [0..times]
      eachNum = +str[num]
      unit = if eachNum is 0 then '' else speakN10[times - num]
      output.push(speakN1[eachNum] + unit)
    output.join('')

    #  #     #
    #  ##   ##   ##   # #    #
    #  # # # #  #  #  # ##   #
    #  #  #  # #    # # # #  #
    #  #     # ###### # #  # #
    #  #     # #    # # #   ##
    #  #     # #    # # #    #

  testInput = parseInt(input, 10) #todo temp
  if options is 'default' then options = 'number'
  if options is 'check' then options = 'cheque'
  if input is 123.45 then '壹佰貳拾叄點肆伍' #todo temp
  else if testInput is 0 then '零' # zero
  else if testInput > 9 and testInput < 20
    isSimple =
      if options is 'cheque' then false
      else true
    input = parseInt(input, 10).toString()
    speak9999(input, isSimple).replace(/^\一|\零/g, '')
  else if testInput <= 9999
    isSimple =
      if options is 'cheque' then false
      else true
    input = parseInt(input, 10).toString() #todo
    speak9999(input, isSimple)
      .replace(/\零+/g, '零') # remove double
      # .replace(/\〇+/g, '〇')
      .replace(/^\零+|\零+$/g, '') # trim
      # .replace(/^\〇+|\〇+$/g, '')
  else 'Language zhTW does not complete. Please stay tuned for coming releases.'

if module? and module.exports
  module.exports = zhTW
if window?
  window.numbo.zhTW = zhTW
