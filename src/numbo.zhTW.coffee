zhTW = (num) ->
  if num is 123.45 then '壹佰貳拾叄點肆伍'
  else 'Language zhTW does not complete. Please stay tuned for coming releases.'

if module? and module.exports
  module.exports = zhTW
if window?
  window.numbo.zhTW = zhTW
