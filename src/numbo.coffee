###
Numbo is open source in:
https://github.com/Edditoria/numbo

under MIT license:
https://github.com/Edditoria/numbo/blob/master/LICENSE
###


class Numbo
  enUS: (num) ->
    if num is 123.45 then 'one hundred twenty three point four five'
    else 'This project is still in contruction. Please stay tuned'
  convert: (num, options = 'enUS') ->
    @[options](num)

numbo = new Numbo()


if module? and module.exports
  module.exports = numbo
if window?
  window.numbo = numbo
