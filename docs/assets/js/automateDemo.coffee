---
---

# (($)->
#   $.fn.typing = (content, speed = 30) ->
#     element = this
#     contentArr = content.split('')
#     contentLen = content.length
#     index = 0
#     func = ->
#       if index < contentLen
#         element.text(element.text() + contentArr[index++])
#       return
#     setInterval(func, speed)
#     return
# )(jQuery)

generateNumboOptions = ->
  generateRandomNum = (min, max) -> Math.random() * (max - min) + min

  numboLang = ['enUS', 'zhTW', 'zhCN']
  numboTpl = ['number', 'amount', 'cheque']
  randomLang = Math.floor(generateRandomNum(0, 3)) # 0, 1 or 2
  randomTpl = Math.floor(generateRandomNum(0, 3)) # 0, 1 or 2

  randomInt = Math.floor(generateRandomNum(1, 100000000)) # 1 to 99,999,999
  randomDecimal =
    if Math.random() < 0.5
      '.' + Math.floor(generateRandomNum(1, 10000))
    else ''
  numboInput = randomInt + randomDecimal

  # return object must fit to numboOptions in typeMsg()
  { input: numboInput, lang: numboLang[randomLang], tpl: numboTpl[randomTpl] }

$ ->

  typeMsg = (numboOptions) ->
    # numboOptions should be { input, lang, tpl }
    # IMPORTANT: this function will assume that window.numbo() exists
    n = numboOptions
    inputMsg = "numbo.convert(\"#{n.input}\", \"#{n.lang}\", \"#{n.tpl}\")"
    outputMsg = '\"' + window.numbo.convert(n.input, n.lang, n.tpl) + '\"'
    callbackFunc = ->
      # remove typed-cursor <span class="typed-cursor">|</span>
      $('.console-command .typed-cursor').remove()
      $('.console-command')
        .append('<p>' + outputMsg + '</p>')
        .append('<p>&gt; <span></span></p>')
    typedOptions =
      strings: [inputMsg]
      callback: callbackFunc
    $('.console-command p:last-child span').typed(typedOptions)
    return

  # output of generateNumboOptions() must fit to numboOptions in typeMsg()
  setInterval((-> typeMsg(generateNumboOptions())), 5000)

  return
