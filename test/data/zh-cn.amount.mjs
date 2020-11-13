export default [
	{
		input: 0,
		expect: '零元',
	},
	{
		input: 1,
		expect: '一元',
	},
	{
		input: 1.01,
		expect: '一元一分',
	},
	{
		input: 1.1,
		expect: '一元一角',
	},
	{
		input: 2,
		expect: '两元',
	},
	{
		input: 2.01,
		expect: '两元一分',
	},
	{
		input: 2.1,
		expect: '两元一角',
	},
	{
		input: 9,
		expect: '九元',
	},
	{
		input: 10,
		expect: '十元',
	},
	{
		input: 11,
		expect: '十一元',
	},
	{
		input: 19,
		expect: '十九元',
	},
	{
		input: 20,
		expect: '二十元',
	},
	{
		input: 21,
		expect: '二十一元',
	},
	{
		input: 88,
		expect: '八十八元',
	},
	{
		input: 100,
		expect: '一百元',
	},
	{
		input: 101,
		expect: '一百零一元',
	},
	{
		input: 180,
		expect: '一百八十元',
	},
	{
		input: 888,
		expect: '八百八十八元',
	},
	{
		input: 0.01,
		expect: '一分',
	},
	{
		input: 0.1,
		expect: '一角',
	},
	{
		input: 0.5,
		expect: '五角',
	},
	{
		input: 0.00001,
		expect: '一分', // { 'input': .00001, 'expect': '零元' }
	},
	{
		input: 1.00001,
		expect: '一元一分', // { 'input': 1.00001, 'expect': '一元' }
	},
	{
		input: 2.00001,
		expect: '两元一分', // { 'input': 2.00001, 'expect': '两元' }
	},
	{
		input: 3.00001,
		expect: '三元一分', // { 'input': 3.00001, 'expect': '三元' }
	},
	{
		input: 1000,
		expect: '一千元',
	},
	{
		input: 1000000,
		expect: '一百万元',
	},
	{
		input: 1234567.89,
		expect: '一百二十三万四千五百六十七元八角九分',
	},
	{
		input: '123.9940',
		expect: '一百二十四元',
	},
	{
		input: '123.9950',
		expect: '一百二十四元',
	},
	{
		input: 'test a string',
		expect: null,
	},
	{
		input: '',
		expect: null,
	},
	{
		input: '0000000',
		expect: '零元',
	},
	{
		input: '0.1',
		expect: '一角',
	},
	{
		input: '00000123.4500000',
		expect: '一百二十三元四角五分',
	},
	{
		input: '1e+100',
		expect: 'Ding! One Google... Oops... One Googol!!',
	},
	{
		// specific tests for this language
		input: 2.02,
		expect: '两元两分',
	},
	{
		input: 2.2,
		expect: '两元两角',
	},
	{
		input: 1001,
		expect: '一千零一元',
	},
	{
		input: 1010,
		expect: '一千零一十元',
	},
	{
		input: 10000,
		expect: '一万元',
	},
	{
		input: 10001,
		expect: '一万零一元',
	},
	{
		input: 10010,
		expect: '一万零一十元',
	},
	{
		input: 10100,
		expect: '一万零一百元',
	},
	{
		input: 11001,
		expect: '一万一千零一元',
	},
	{
		input: 11011,
		expect: '一万一千零一十一元',
	},
	{
		input: 10101,
		expect: '一万零一百零一元',
	},
	{
		input: 100101,
		expect: '十万零一百零一元',
	},
	{
		input: 1001010,
		expect: '一百万一千零一十元',
	},
	{
		input: 10001010,
		expect: '一千万一千零一十元',
	},
	{
		input: 100000000,
		expect: '一亿元',
	},
	{
		input: 100001010,
		expect: '一亿零一千零一十元',
	},
	{
		input: 1000000000001001,
		expect: '一千兆零一千零一元',
	},
	{
		input: '1000000000000001001',
		expect: '一百京零一千零一元',
	},
];
