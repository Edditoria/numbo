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

import enUS from './en-us.coffee'

class Numbo

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

  convert_enUS = enUS
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

export default numbo
