'use strict';

var enUSAmount = [
  {
    'input': 0,
    'expect': 'null'
  },
  {
    'input': 1,
    'expect': 'one dollar'
  },
  {
    'input': 1.01,
    'expect': 'one dollar and one cent'
  },
  {
    'input': 1.1,
    'expect': 'one dollar and ten cents'
  },
  {
    'input': 2,
    'expect': 'two dollars'
  },
  {
    'input': 2.01,
    'expect': 'two dollars and one cent'
  },
  {
    'input': 2.1,
    'expect': 'two dollars and ten cents'
  },
  {
    'input': 9,
    'expect': 'nine dollars'
  },
  {
    'input': 10,
    'expect': 'ten dollars'
  },
  {
    'input': 11,
    'expect': 'eleven dollars'
  },
  {
    'input': 19,
    'expect': 'nineteen dollars'
  },
  {
    'input': 20,
    'expect': 'twenty dollars'
  },
  {
    'input': 21,
    'expect': 'twenty-one dollars'
  },
  {
    'input': 88,
    'expect': 'eighty-eight dollars'
  },
  {
    'input': 100,
    'expect': 'one hundred dollars'
  },
  {
    'input': 101,
    'expect': 'one hundred one dollars'
  },
  {
    'input': 180,
    'expect': 'one hundred eighty dollars'
  },
  {
    'input': 888,
    'expect': 'eight hundred eighty-eight dollars'
  },
  {
    'input': 0.01,
    'expect': 'one cent'
  },
  {
    'input': 0.1,
    'expect': 'ten cents'
  },
  {
    'input': .50,
    'expect': 'fifty cents'
  },
  {
    'input': .00001,
    'expect': 'one cent' // { 'input': .00001, 'expect': 'null' }
  },
  {
    'input': 1.00001,
    'expect': 'one dollar and one cent' // { 'input': 1.00001, 'expect': 'one dollar' }
  },
  {
    'input': 2.00001,
    'expect': 'two dollars and one cent' // { 'input': 2.00001, 'expect': 'two dollars' }
  },
  {
    'input': 3.00001,
    'expect': 'three dollars and one cent' // { 'input': 3.00001, 'expect': 'three dollars' }
  },
  {
    'input': 1000,
    'expect': 'one thousand dollars'
  },
  {
    'input': 1000000,
    'expect': 'one million dollars'
  },
  {
    'input': 1234567.89,
    'expect': 'one million two hundred thirty-four thousand five hundred sixty-seven dollars and eighty-nine cents'
  },
  {
    'input': '123.9940',
    'expect': 'one hundred twenty-four dollars'
  },
  {
    'input': '123.9950',
    'expect': 'one hundred twenty-four dollars'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': 'null'
  },
  {
    'input': '0.1',
    'expect': 'ten cents'
  },
  {
    'input': '00000123.4500000',
    'expect': 'one hundred twenty-three dollars and forty-five cents'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  }
];

var enUSCheque = [
  {
    'input': 0,
    'expect': 'Null'
  },
  {
    'input': 1,
    'expect': 'One Dollar and No Cent Only'
  },
  {
    'input': 1.01,
    'expect': 'One Dollar and One Cent Only'
  },
  {
    'input': 1.1,
    'expect': 'One Dollar and Ten Cents Only'
  },
  {
    'input': 2,
    'expect': 'Two Dollars and No Cent Only'
  },
  {
    'input': 2.01,
    'expect': 'Two Dollars and One Cent Only'
  },
  {
    'input': 2.1,
    'expect': 'Two Dollars and Ten Cents Only'
  },
  {
    'input': 9,
    'expect': 'Nine Dollars and No Cent Only'
  },
  {
    'input': 10,
    'expect': 'Ten Dollars and No Cent Only'
  },
  {
    'input': 11,
    'expect': 'Eleven Dollars and No Cent Only'
  },
  {
    'input': 19,
    'expect': 'Nineteen Dollars and No Cent Only'
  },
  {
    'input': 20,
    'expect': 'Twenty Dollars and No Cent Only'
  },
  {
    'input': 21,
    'expect': 'Twenty-one Dollars and No Cent Only'
  },
  {
    'input': 88,
    'expect': 'Eighty-eight Dollars and No Cent Only'
  },
  {
    'input': 100,
    'expect': 'One Hundred Dollars and No Cent Only'
  },
  {
    'input': 101,
    'expect': 'One Hundred One Dollars and No Cent Only'
  },
  {
    'input': 180,
    'expect': 'One Hundred Eighty Dollars and No Cent Only'
  },
  {
    'input': 888,
    'expect': 'Eight Hundred Eighty-eight Dollars and No Cent Only'
  },
  {
    'input': 0.01,
    'expect': 'One Cent Only'
  },
  {
    'input': 0.1,
    'expect': 'Ten Cents Only'
  },
  {
    'input': .50,
    'expect': 'Fifty Cents Only'
  },
  {
    'input': .00001,
    'expect': 'One Cent Only' // { 'input': .00001, 'expect': 'Null' }
  },
  {
    'input': 1.00001,
    'expect': 'One Dollar and One Cent Only' // { 'input': 1.00001, 'expect': 'One Dollar and No Cent Only' }
  },
  {
    'input': 2.00001,
    'expect': 'Two Dollars and One Cent Only' // { 'input': 2.00001, 'expect': 'Two Dollars and No Cent Only' }
  },
  {
    'input': 3.00001,
    'expect': 'Three Dollars and One Cent Only' // { 'input': 3.00001, 'expect': 'Three Dollars and No Cent Only' }
  },
  {
    'input': 1000,
    'expect': 'One Thousand Dollars and No Cent Only'
  },
  {
    'input': 1000000,
    'expect': 'One Million Dollars and No Cent Only'
  },
  {
    'input': 1234567.89,
    'expect': 'One Million Two Hundred Thirty-four Thousand Five Hundred Sixty-seven Dollars and Eighty-nine Cents Only'
  },
  {
    'input': '123.9940',
    'expect': 'One Hundred Twenty-four Dollars and No Cent Only'
  },
  {
    'input': '123.9950',
    'expect': 'One Hundred Twenty-four Dollars and No Cent Only'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': 'Null'
  },
  {
    'input': '0.1',
    'expect': 'Ten Cents Only'
  },
  {
    'input': '00000123.4500000',
    'expect': 'One Hundred Twenty-three Dollars and Forty-five Cents Only'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  }
];

var enUSNumber = [
  {
    'input': 0,
    'expect': 'zero'
  },
  {
    'input': 1,
    'expect': 'one'
  },
  {
    'input': 1.01,
    'expect': 'one point zero one'
  },
  {
    'input': 1.1,
    'expect': 'one point one'
  },
  {
    'input': 2,
    'expect': 'two'
  },
  {
    'input': 2.01,
    'expect': 'two point zero one'
  },
  {
    'input': 2.1,
    'expect': 'two point one'
  },
  {
    'input': 9,
    'expect': 'nine'
  },
  {
    'input': 10,
    'expect': 'ten'
  },
  {
    'input': 11,
    'expect': 'eleven'
  },
  {
    'input': 19,
    'expect': 'nineteen'
  },
  {
    'input': 20,
    'expect': 'twenty'
  },
  {
    'input': 21,
    'expect': 'twenty-one'
  },
  {
    'input': 88,
    'expect': 'eighty-eight'
  },
  {
    'input': 100,
    'expect': 'one hundred'
  },
  {
    'input': 101,
    'expect': 'one hundred and one'
  },
  {
    'input': 180,
    'expect': 'one hundred and eighty'
  },
  {
    'input': 888,
    'expect': 'eight hundred and eighty-eight'
  },
  {
    'input': 0.01,
    'expect': 'zero point zero one'
  },
  {
    'input': 0.1,
    'expect': 'zero point one'
  },
  {
    'input': .50,
    'expect': 'zero point five'
  },
  {
    'input': .00001,
    'expect': 'zero point zero zero zero zero one'
  },
  {
    'input': 1.00001,
    'expect': 'one point zero zero zero zero one'
  },
  {
    'input': 2.00001,
    'expect': 'two point zero zero zero zero one'
  },
  {
    'input': 3.00001,
    'expect': 'three point zero zero zero zero one'
  },
  {
    'input': 1000,
    'expect': 'one thousand'
  },
  {
    'input': 1000000,
    'expect': 'one million'
  },
  {
    'input': 1234567.89,
    'expect': 'one million two hundred and thirty-four thousand five hundred and sixty-seven point eight nine'
  },
  {
    'input': '123.9940',
    'expect': 'one hundred and twenty-three point nine nine four'
  },
  {
    'input': '123.9950',
    'expect': 'one hundred and twenty-three point nine nine five'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': 'zero'
  },
  {
    'input': '0.1',
    'expect': 'zero point one'
  },
  {
    'input': '00000123.4500000',
    'expect': 'one hundred and twenty-three point four five'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  }
];

var zhTWAmount = [
  {
    'input': 0,
    'expect': '零元'
  },
  {
    'input': 1,
    'expect': '一元'
  },
  {
    'input': 1.01,
    'expect': '一元一分'
  },
  {
    'input': 1.1,
    'expect': '一元一角'
  },
  {
    'input': 2,
    'expect': '兩元'
  },
  {
    'input': 2.01,
    'expect': '兩元一分'
  },
  {
    'input': 2.1,
    'expect': '兩元一角'
  },
  {
    'input': 9,
    'expect': '九元'
  },
  {
    'input': 10,
    'expect': '十元'
  },
  {
    'input': 11,
    'expect': '十一元'
  },
  {
    'input': 19,
    'expect': '十九元'
  },
  {
    'input': 20,
    'expect': '二十元'
  },
  {
    'input': 21,
    'expect': '二十一元'
  },
  {
    'input': 88,
    'expect': '八十八元'
  },
  {
    'input': 100,
    'expect': '一百元'
  },
  {
    'input': 101,
    'expect': '一百零一元'
  },
  {
    'input': 180,
    'expect': '一百八十元'
  },
  {
    'input': 888,
    'expect': '八百八十八元'
  },
  {
    'input': 0.01,
    'expect': '一分'
  },
  {
    'input': 0.1,
    'expect': '一角'
  },
  {
    'input': .50,
    'expect': '五角'
  },
  {
    'input': .00001,
    'expect': '一分' // { 'input': .00001, 'expect': '零元' }
  },
  {
    'input': 1.00001,
    'expect': '一元一分' // { 'input': 1.00001, 'expect': '一元' }
  },
  {
    'input': 2.00001,
    'expect': '兩元一分' // { 'input': 2.00001, 'expect': '兩元' }
  },
  {
    'input': 3.00001,
    'expect': '三元一分' // { 'input': 3.00001, 'expect': '三元' }
  },
  {
    'input': 1000,
    'expect': '一千元'
  },
  {
    'input': 1000000,
    'expect': '一百萬元'
  },
  {
    'input': 1234567.89,
    'expect': '一百二十三萬四千五百六十七元八角九分'
  },
  {
    'input': '123.9940',
    'expect': '一百二十四元'
  },
  {
    'input': '123.9950',
    'expect': '一百二十四元'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零元'
  },
  {
    'input': '0.1',
    'expect': '一角'
  },
  {
    'input': '00000123.4500000',
    'expect': '一百二十三元四角五分'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 2.02,
    'expect': '兩元兩分'
  },
  {
    'input': 2.2,
    'expect': '兩元兩角'
  },
  {
    'input': 1001,
    'expect': '一千零一元'
  },
  {
    'input': 1010,
    'expect': '一千零一十元'
  },
  {
    'input': 10000,
    'expect': '一萬元'
  },
  {
    'input': 10001,
    'expect': '一萬零一元'
  },
  {
    'input': 10010,
    'expect': '一萬零一十元'
  },
  {
    'input': 10100,
    'expect': '一萬零一百元'
  },
  {
    'input': 11001,
    'expect': '一萬一千零一元'
  },
  {
    'input': 11011,
    'expect': '一萬一千零一十一元'
  },
  {
    'input': 10101,
    'expect': '一萬零一百零一元'
  },
  {
    'input': 100101,
    'expect': '十萬零一百零一元'
  },
  {
    'input': 1001010,
    'expect': '一百萬一千零一十元'
  },
  {
    'input': 10001010,
    'expect': '一千萬一千零一十元'
  },
  {
    'input': 100000000,
    'expect': '一億元'
  },
  {
    'input': 100001010,
    'expect': '一億零一千零一十元'
  },
  {
    'input': 1000000000001001,
    'expect': '一千兆零一千零一元'
  },
  {
    'input': '1000000000000001001',
    'expect': '一百京零一千零一元'
  }
];

var zhTWCheque = [
  {
    'input': 0,
    'expect': '零元'
  },
  {
    'input': 1,
    'expect': '壹元正'
  },
  {
    'input': 1.01,
    'expect': '壹元壹分'
  },
  {
    'input': 1.1,
    'expect': '壹元壹角'
  },
  {
    'input': 2,
    'expect': '貳元正'
  },
  {
    'input': 2.01,
    'expect': '貳元壹分'
  },
  {
    'input': 2.1,
    'expect': '貳元壹角'
  },
  {
    'input': 9,
    'expect': '玖元正'
  },
  {
    'input': 10,
    'expect': '拾元正'
  },
  {
    'input': 11,
    'expect': '拾壹元正'
  },
  {
    'input': 19,
    'expect': '拾玖元正'
  },
  {
    'input': 20,
    'expect': '貳拾元正'
  },
  {
    'input': 21,
    'expect': '貳拾壹元正'
  },
  {
    'input': 88,
    'expect': '捌拾捌元正'
  },
  {
    'input': 100,
    'expect': '壹佰元正'
  },
  {
    'input': 101,
    'expect': '壹佰零壹元正'
  },
  {
    'input': 180,
    'expect': '壹佰捌拾元正'
  },
  {
    'input': 888,
    'expect': '捌佰捌拾捌元正'
  },
  {
    'input': 0.01,
    'expect': '壹分'
  },
  {
    'input': 0.1,
    'expect': '壹角'
  },
  {
    'input': .50,
    'expect': '伍角'
  },
  {
    'input': .00001,
    'expect': '壹分' // { 'input': .00001, 'expect': '零元' }
  },
  {
    'input': 1.00001,
    'expect': '壹元壹分' // { 'input': 1.00001, 'expect': '壹元正' }
  },
  {
    'input': 2.00001,
    'expect': '貳元壹分' // { 'input': 2.00001, 'expect': '貳元正' }
  },
  {
    'input': 3.00001,
    'expect': '叁元壹分' // { 'input': 3.00001, 'expect': '叁元正' }
  },
  {
    'input': 1000,
    'expect': '壹仟元正'
  },
  {
    'input': 1000000,
    'expect': '壹佰萬元正'
  },
  {
    'input': 1234567.89,
    'expect': '壹佰貳拾叁萬肆仟伍佰陸拾柒元捌角玖分'
  },
  {
    'input': '123.9940',
    'expect': '壹佰貳拾肆元正'
  },
  {
    'input': '123.9950',
    'expect': '壹佰貳拾肆元正'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零元'
  },
  {
    'input': '0.1',
    'expect': '壹角'
  },
  {
    'input': '00000123.4500000',
    'expect': '壹佰貳拾叁元肆角伍分'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 2.02,
    'expect': '貳元貳分'
  },
  {
    'input': 2.2,
    'expect': '貳元貳角'
  },
  {
    'input': 1001,
    'expect': '壹仟零壹元正'
  },
  {
    'input': 1010,
    'expect': '壹仟零壹拾元正'
  },
  {
    'input': 10000,
    'expect': '壹萬元正'
  },
  {
    'input': 10001,
    'expect': '壹萬零壹元正'
  },
  {
    'input': 10010,
    'expect': '壹萬零壹拾元正'
  },
  {
    'input': 10100,
    'expect': '壹萬零壹佰元正'
  },
  {
    'input': 11001,
    'expect': '壹萬壹仟零壹元正'
  },
  {
    'input': 11011,
    'expect': '壹萬壹仟零壹拾壹元正'
  },
  {
    'input': 10101,
    'expect': '壹萬零壹佰零壹元正'
  },
  {
    'input': 100101,
    'expect': '拾萬零壹佰零壹元正'
  },
  {
    'input': 1001010,
    'expect': '壹佰萬壹仟零壹拾元正'
  },
  {
    'input': 10001010,
    'expect': '壹仟萬壹仟零壹拾元正'
  },
  {
    'input': 100000000,
    'expect': '壹億元正'
  },
  {
    'input': 100001010,
    'expect': '壹億零壹仟零壹拾元正'
  },
  {
    'input': 1000000000001001,
    'expect': '壹仟兆零壹仟零壹元正'
  },
  {
    'input': '1000000000000001001',
    'expect': '壹佰京零壹仟零壹元正'
  }
];

var zhTWNumber = [
  {
    'input': 0,
    'expect': '零'
  },
  {
    'input': 1,
    'expect': '一'
  },
  {
    'input': 1.01,
    'expect': '一點零一'
  },
  {
    'input': 1.1,
    'expect': '一點一'
  },
  {
    'input': 2,
    'expect': '二'
  },
  {
    'input': 2.01,
    'expect': '二點零一'
  },
  {
    'input': 2.1,
    'expect': '二點一'
  },
  {
    'input': 9,
    'expect': '九'
  },
  {
    'input': 10,
    'expect': '十'
  },
  {
    'input': 11,
    'expect': '十一'
  },
  {
    'input': 19,
    'expect': '十九'
  },
  {
    'input': 20,
    'expect': '二十'
  },
  {
    'input': 21,
    'expect': '二十一'
  },
  {
    'input': 88,
    'expect': '八十八'
  },
  {
    'input': 100,
    'expect': '一百'
  },
  {
    'input': 101,
    'expect': '一百零一'
  },
  {
    'input': 180,
    'expect': '一百八十'
  },
  {
    'input': 888,
    'expect': '八百八十八'
  },
  {
    'input': 0.01,
    'expect': '零點零一'
  },
  {
    'input': 0.1,
    'expect': '零點一'
  },
  {
    'input': .50,
    'expect': '零點五'
  },
  {
    'input': .00001,
    'expect': '零點零零零零一'
  },
  {
    'input': 1.00001,
    'expect': '一點零零零零一'
  },
  {
    'input': 2.00001,
    'expect': '二點零零零零一'
  },
  {
    'input': 3.00001,
    'expect': '三點零零零零一'
  },
  {
    'input': 1000,
    'expect': '一千'
  },
  {
    'input': 1000000,
    'expect': '一百萬'
  },
  {
    'input': 1234567.89,
    'expect': '一百二十三萬四千五百六十七點八九'
  },
  {
    'input': '123.9940',
    'expect': '一百二十三點九九四'
  },
  {
    'input': '123.9950',
    'expect': '一百二十三點九九五'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零'
  },
  {
    'input': '0.1',
    'expect': '零點一'
  },
  {
    'input': '00000123.4500000',
    'expect': '一百二十三點四五'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 1001,
    'expect': '一千零一'
  },
  {
    'input': 1010,
    'expect': '一千零一十'
  },
  {
    'input': 10000,
    'expect': '一萬'
  },
  {
    'input': 10001,
    'expect': '一萬零一'
  },
  {
    'input': 10010,
    'expect': '一萬零一十'
  },
  {
    'input': 10100,
    'expect': '一萬零一百'
  },
  {
    'input': 11001,
    'expect': '一萬一千零一'
  },
  {
    'input': 11011,
    'expect': '一萬一千零一十一'
  },
  {
    'input': 10101,
    'expect': '一萬零一百零一'
  },
  {
    'input': 100101,
    'expect': '十萬零一百零一'
  },
  {
    'input': 1001010,
    'expect': '一百萬一千零一十'
  },
  {
    'input': 10001010,
    'expect': '一千萬一千零一十'
  },
  {
    'input': 100000000,
    'expect': '一億'
  },
  {
    'input': 100001010,
    'expect': '一億零一千零一十'
  },
  {
    'input': 1000000000001001,
    'expect': '一千兆零一千零一'
  },
  {
    'input': '1000000000000001001',
    'expect': '一百京零一千零一'
  }
];

var zhCNAmount = [
  {
    'input': 0,
    'expect': '零元'
  },
  {
    'input': 1,
    'expect': '一元'
  },
  {
    'input': 1.01,
    'expect': '一元一分'
  },
  {
    'input': 1.1,
    'expect': '一元一角'
  },
  {
    'input': 2,
    'expect': '两元'
  },
  {
    'input': 2.01,
    'expect': '两元一分'
  },
  {
    'input': 2.1,
    'expect': '两元一角'
  },
  {
    'input': 9,
    'expect': '九元'
  },
  {
    'input': 10,
    'expect': '十元'
  },
  {
    'input': 11,
    'expect': '十一元'
  },
  {
    'input': 19,
    'expect': '十九元'
  },
  {
    'input': 20,
    'expect': '二十元'
  },
  {
    'input': 21,
    'expect': '二十一元'
  },
  {
    'input': 88,
    'expect': '八十八元'
  },
  {
    'input': 100,
    'expect': '一百元'
  },
  {
    'input': 101,
    'expect': '一百零一元'
  },
  {
    'input': 180,
    'expect': '一百八十元'
  },
  {
    'input': 888,
    'expect': '八百八十八元'
  },
  {
    'input': 0.01,
    'expect': '一分'
  },
  {
    'input': 0.1,
    'expect': '一角'
  },
  {
    'input': .50,
    'expect': '五角'
  },
  {
    'input': .00001,
    'expect': '一分' // { 'input': .00001, 'expect': '零元' }
  },
  {
    'input': 1.00001,
    'expect': '一元一分' // { 'input': 1.00001, 'expect': '一元' }
  },
  {
    'input': 2.00001,
    'expect': '两元一分' // { 'input': 2.00001, 'expect': '两元' }
  },
  {
    'input': 3.00001,
    'expect': '三元一分' // { 'input': 3.00001, 'expect': '三元' }
  },
  {
    'input': 1000,
    'expect': '一千元'
  },
  {
    'input': 1000000,
    'expect': '一百万元'
  },
  {
    'input': 1234567.89,
    'expect': '一百二十三万四千五百六十七元八角九分'
  },
  {
    'input': '123.9940',
    'expect': '一百二十四元'
  },
  {
    'input': '123.9950',
    'expect': '一百二十四元'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零元'
  },
  {
    'input': '0.1',
    'expect': '一角'
  },
  {
    'input': '00000123.4500000',
    'expect': '一百二十三元四角五分'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 2.02,
    'expect': '两元两分'
  },
  {
    'input': 2.2,
    'expect': '两元两角'
  },
  {
    'input': 1001,
    'expect': '一千零一元'
  },
  {
    'input': 1010,
    'expect': '一千零一十元'
  },
  {
    'input': 10000,
    'expect': '一万元'
  },
  {
    'input': 10001,
    'expect': '一万零一元'
  },
  {
    'input': 10010,
    'expect': '一万零一十元'
  },
  {
    'input': 10100,
    'expect': '一万零一百元'
  },
  {
    'input': 11001,
    'expect': '一万一千零一元'
  },
  {
    'input': 11011,
    'expect': '一万一千零一十一元'
  },
  {
    'input': 10101,
    'expect': '一万零一百零一元'
  },
  {
    'input': 100101,
    'expect': '十万零一百零一元'
  },
  {
    'input': 1001010,
    'expect': '一百万一千零一十元'
  },
  {
    'input': 10001010,
    'expect': '一千万一千零一十元'
  },
  {
    'input': 100000000,
    'expect': '一亿元'
  },
  {
    'input': 100001010,
    'expect': '一亿零一千零一十元'
  },
  {
    'input': 1000000000001001,
    'expect': '一千兆零一千零一元'
  },
  {
    'input': '1000000000000001001',
    'expect': '一百京零一千零一元'
  }
];

var zhCNCheque = [
  {
    'input': 0,
    'expect': '零元'
  },
  {
    'input': 1,
    'expect': '壹元整'
  },
  {
    'input': 1.01,
    'expect': '壹元壹分'
  },
  {
    'input': 1.1,
    'expect': '壹元壹角'
  },
  {
    'input': 2,
    'expect': '贰元整'
  },
  {
    'input': 2.01,
    'expect': '贰元壹分'
  },
  {
    'input': 2.1,
    'expect': '贰元壹角'
  },
  {
    'input': 9,
    'expect': '玖元整'
  },
  {
    'input': 10,
    'expect': '拾元整'
  },
  {
    'input': 11,
    'expect': '拾壹元整'
  },
  {
    'input': 19,
    'expect': '拾玖元整'
  },
  {
    'input': 20,
    'expect': '贰拾元整'
  },
  {
    'input': 21,
    'expect': '贰拾壹元整'
  },
  {
    'input': 88,
    'expect': '捌拾捌元整'
  },
  {
    'input': 100,
    'expect': '壹佰元整'
  },
  {
    'input': 101,
    'expect': '壹佰零壹元整'
  },
  {
    'input': 180,
    'expect': '壹佰捌拾元整'
  },
  {
    'input': 888,
    'expect': '捌佰捌拾捌元整'
  },
  {
    'input': 0.01,
    'expect': '壹分'
  },
  {
    'input': 0.1,
    'expect': '壹角'
  },
  {
    'input': .50,
    'expect': '伍角'
  },
  {
    'input': .00001,
    'expect': '壹分' // { 'input': .00001, 'expect': '零元' }
  },
  {
    'input': 1.00001,
    'expect': '壹元壹分' // { 'input': 1.00001, 'expect': '壹元整' }
  },
  {
    'input': 2.00001,
    'expect': '贰元壹分' // { 'input': 2.00001, 'expect': '贰元整' }
  },
  {
    'input': 3.00001,
    'expect': '叁元壹分' // { 'input': 3.00001, 'expect': '叁元整' }
  },
  {
    'input': 1000,
    'expect': '壹仟元整'
  },
  {
    'input': 1000000,
    'expect': '壹佰万元整'
  },
  {
    'input': 1234567.89,
    'expect': '壹佰贰拾叁万肆仟伍佰陆拾柒元捌角玖分'
  },
  {
    'input': '123.9940',
    'expect': '壹佰贰拾肆元整'
  },
  {
    'input': '123.9950',
    'expect': '壹佰贰拾肆元整'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零元'
  },
  {
    'input': '0.1',
    'expect': '壹角'
  },
  {
    'input': '00000123.4500000',
    'expect': '壹佰贰拾叁元肆角伍分'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 2.02,
    'expect': '贰元贰分'
  },
  {
    'input': 2.2,
    'expect': '贰元贰角'
  },
  {
    'input': 1001,
    'expect': '壹仟零壹元整'
  },
  {
    'input': 1010,
    'expect': '壹仟零壹拾元整'
  },
  {
    'input': 10000,
    'expect': '壹万元整'
  },
  {
    'input': 10001,
    'expect': '壹万零壹元整'
  },
  {
    'input': 10010,
    'expect': '壹万零壹拾元整'
  },
  {
    'input': 10100,
    'expect': '壹万零壹佰元整'
  },
  {
    'input': 11001,
    'expect': '壹万壹仟零壹元整'
  },
  {
    'input': 11011,
    'expect': '壹万壹仟零壹拾壹元整'
  },
  {
    'input': 10101,
    'expect': '壹万零壹佰零壹元整'
  },
  {
    'input': 100101,
    'expect': '拾万零壹佰零壹元整'
  },
  {
    'input': 1001010,
    'expect': '壹佰万壹仟零壹拾元整'
  },
  {
    'input': 10001010,
    'expect': '壹仟万壹仟零壹拾元整'
  },
  {
    'input': 100000000,
    'expect': '壹亿元整'
  },
  {
    'input': 100001010,
    'expect': '壹亿零壹仟零壹拾元整'
  },
  {
    'input': 1000000000001001,
    'expect': '壹仟兆零壹仟零壹元整'
  },
  {
    'input': '1000000000000001001',
    'expect': '壹佰京零壹仟零壹元整'
  }
];

var zhCNNumber = [
  {
    'input': 0,
    'expect': '零'
  },
  {
    'input': 1,
    'expect': '一'
  },
  {
    'input': 1.01,
    'expect': '一点零一'
  },
  {
    'input': 1.1,
    'expect': '一点一'
  },
  {
    'input': 2,
    'expect': '二'
  },
  {
    'input': 2.01,
    'expect': '二点零一'
  },
  {
    'input': 2.1,
    'expect': '二点一'
  },
  {
    'input': 9,
    'expect': '九'
  },
  {
    'input': 10,
    'expect': '十'
  },
  {
    'input': 11,
    'expect': '十一'
  },
  {
    'input': 19,
    'expect': '十九'
  },
  {
    'input': 20,
    'expect': '二十'
  },
  {
    'input': 21,
    'expect': '二十一'
  },
  {
    'input': 88,
    'expect': '八十八'
  },
  {
    'input': 100,
    'expect': '一百'
  },
  {
    'input': 101,
    'expect': '一百零一'
  },
  {
    'input': 180,
    'expect': '一百八十'
  },
  {
    'input': 888,
    'expect': '八百八十八'
  },
  {
    'input': 0.01,
    'expect': '零点零一'
  },
  {
    'input': 0.1,
    'expect': '零点一'
  },
  {
    'input': .50,
    'expect': '零点五'
  },
  {
    'input': .00001,
    'expect': '零点零零零零一'
  },
  {
    'input': 1.00001,
    'expect': '一点零零零零一'
  },
  {
    'input': 2.00001,
    'expect': '二点零零零零一'
  },
  {
    'input': 3.00001,
    'expect': '三点零零零零一'
  },
  {
    'input': 1000,
    'expect': '一千'
  },
  {
    'input': 1000000,
    'expect': '一百万'
  },
  {
    'input': 1234567.89,
    'expect': '一百二十三万四千五百六十七点八九'
  },
  {
    'input': '123.9940',
    'expect': '一百二十三点九九四'
  },
  {
    'input': '123.9950',
    'expect': '一百二十三点九九五'
  },
  {
    'input': 'test a string',
    'expect': null
  },
  {
    'input': '',
    'expect': null
  },
  {
    'input': '0000000',
    'expect': '零'
  },
  {
    'input': '0.1',
    'expect': '零点一'
  },
  {
    'input': '00000123.4500000',
    'expect': '一百二十三点四五'
  },
  {
    'input': '1e+100',
    'expect': 'Ding! One Google... Oops... One Googol!!'
  },
  {
    // specific tests for this language
    'input': 2.02,
    'expect': '二点零二'
  },
  {
    'input': 2.2,
    'expect': '二点二'
  },
  {
    'input': 1001,
    'expect': '一千零一'
  },
  {
    'input': 1010,
    'expect': '一千零一十'
  },
  {
    'input': 10000,
    'expect': '一万'
  },
  {
    'input': 10001,
    'expect': '一万零一'
  },
  {
    'input': 10010,
    'expect': '一万零一十'
  },
  {
    'input': 10100,
    'expect': '一万零一百'
  },
  {
    'input': 11001,
    'expect': '一万一千零一'
  },
  {
    'input': 11011,
    'expect': '一万一千零一十一'
  },
  {
    'input': 10101,
    'expect': '一万零一百零一'
  },
  {
    'input': 100101,
    'expect': '十万零一百零一'
  },
  {
    'input': 1001010,
    'expect': '一百万一千零一十'
  },
  {
    'input': 10001010,
    'expect': '一千万一千零一十'
  },
  {
    'input': 100000000,
    'expect': '一亿'
  },
  {
    'input': 100001010,
    'expect': '一亿零一千零一十'
  },
  {
    'input': 1000000000001001,
    'expect': '一千兆零一千零一'
  },
  {
    'input': '1000000000000001001',
    'expect': '一百京零一千零一'
  }
];

var allData = {
  /**
  @typedef {Object} Data - A JSON-like series of test data in structure of data[lang][type][testObj...]
  @property {Object.<Lang>.<Type>.<string|number>} input - Test input arg for running numbo()
  @property {Object.<Lang>.<Type>.<?string>} expect - Expected result for running numbo()
  @typedef {Object} Lang - One of { enUS, zhTW, zhCN } as property of Data
  @typedef {Object} Type - One of { amount, cheque, number } as property of Lang
  */
  enUS: {
    amount: enUSAmount,
    cheque: enUSCheque,
    number: enUSNumber
  },
  zhTW: {
    amount: zhTWAmount,
    cheque: zhTWCheque,
    number: zhTWNumber
  },
  zhCN: {
    amount: zhCNAmount,
    cheque: zhCNCheque,
    number: zhCNNumber
  }
};

module.exports = allData;
