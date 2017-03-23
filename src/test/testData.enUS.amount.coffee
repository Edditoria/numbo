module.exports = [
  {'input': 0, 'expect': 'null'}
  {'input': 1, 'expect': 'one dollar'}
  {'input': 1.01, 'expect': 'one dollar and one cent'}
  {'input': 1.1, 'expect': 'one dollar and ten cents'}
  {'input': 2, 'expect': 'two dollars'}
  {'input': 2.01, 'expect': 'two dollars and one cent'}
  {'input': 2.1, 'expect': 'two dollars and ten cents'}
  {'input': 9, 'expect': 'nine dollars'}
  {'input': 10, 'expect': 'ten dollars'}
  {'input': 11, 'expect': 'eleven dollars'}
  {'input': 19, 'expect': 'nineteen dollars'}
  {'input': 20, 'expect': 'twenty dollars'}
  {'input': 21, 'expect': 'twenty-one dollars'}
  {'input': 88, 'expect': 'eighty-eight dollars'}
  {'input': 100, 'expect': 'one hundred dollars'}
  {'input': 101, 'expect': 'one hundred one dollars'}
  {'input': 180, 'expect': 'one hundred eighty dollars'}
  {'input': 888, 'expect': 'eight hundred eighty-eight dollars'}
  {'input': 0.01, 'expect': 'one cent'}
  {'input': 0.1, 'expect': 'ten cents'}
  {'input': .50, 'expect': 'fifty cents'}
  {'input': .00001, 'expect': 'null'}
  {'input': 1.00001, 'expect': 'one dollar'}
  {'input': 2.00001, 'expect': 'two dollars'}
  {'input': 3.00001, 'expect': 'three dollars'}
  {'input': 1000, 'expect': 'one thousand dollars'}
  {'input': 1000000, 'expect': 'one million dollars'}
  {'input': 1234567.89, 'expect': 'one million two hundred thirty-four thousand five hundred sixty-seven dollars and eighty-nine cents'}
  {'input': 'test a string', 'expect': null}
  {'input': '1e+100', 'expect': 'Ding! One Google... Oops... One Googol!!'}

]
