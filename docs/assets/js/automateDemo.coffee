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

$ ->

  typeMsg = (inputObj, options) ->
    inputMsg = "numbo.convert(\"#{inputObj.input}\", \"#{inputObj.lang}\", \"#{inputObj.template}\")"
    outputMsg = '\"' + window.numbo.convert(inputObj.input, inputObj.lang, inputObj.template) + '\"'
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

  testInput =
    input: '123'
    lang: 'zhTW'
    template: 'amount'
  setInterval((-> typeMsg(testInput)), 4000)

  return
