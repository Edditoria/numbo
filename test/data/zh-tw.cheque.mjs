export default [
	{
		input: 0,
		expect: '零元',
	},
	{
		input: 1,
		expect: '壹元正',
	},
	{
		input: 1.01,
		expect: '壹元壹分',
	},
	{
		input: 1.1,
		expect: '壹元壹角',
	},
	{
		input: 2,
		expect: '貳元正',
	},
	{
		input: 2.01,
		expect: '貳元壹分',
	},
	{
		input: 2.1,
		expect: '貳元壹角',
	},
	{
		input: 9,
		expect: '玖元正',
	},
	{
		input: 10,
		expect: '拾元正',
	},
	{
		input: 11,
		expect: '拾壹元正',
	},
	{
		input: 19,
		expect: '拾玖元正',
	},
	{
		input: 20,
		expect: '貳拾元正',
	},
	{
		input: 21,
		expect: '貳拾壹元正',
	},
	{
		input: 88,
		expect: '捌拾捌元正',
	},
	{
		input: 100,
		expect: '壹佰元正',
	},
	{
		input: 101,
		expect: '壹佰零壹元正',
	},
	{
		input: 180,
		expect: '壹佰捌拾元正',
	},
	{
		input: 888,
		expect: '捌佰捌拾捌元正',
	},
	{
		input: 0.01,
		expect: '壹分',
	},
	{
		input: 0.1,
		expect: '壹角',
	},
	{
		input: 0.5,
		expect: '伍角',
	},
	{
		input: 0.00001,
		expect: '壹分', // { 'input': .00001, 'expect': '零元' }
	},
	{
		input: 1.00001,
		expect: '壹元壹分', // { 'input': 1.00001, 'expect': '壹元正' }
	},
	{
		input: 2.00001,
		expect: '貳元壹分', // { 'input': 2.00001, 'expect': '貳元正' }
	},
	{
		input: 3.00001,
		expect: '叁元壹分', // { 'input': 3.00001, 'expect': '叁元正' }
	},
	{
		input: 1000,
		expect: '壹仟元正',
	},
	{
		input: 1000000,
		expect: '壹佰萬元正',
	},
	{
		input: 1234567.89,
		expect: '壹佰貳拾叁萬肆仟伍佰陸拾柒元捌角玖分',
	},
	{
		input: '123.9940',
		expect: '壹佰貳拾肆元正',
	},
	{
		input: '123.9950',
		expect: '壹佰貳拾肆元正',
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
		expect: '壹角',
	},
	{
		input: '00000123.4500000',
		expect: '壹佰貳拾叁元肆角伍分',
	},
	{
		input: '1e+100',
		expect: 'Ding! One Google... Oops... One Googol!!',
	},
	{
		// specific tests for this language
		input: 2.02,
		expect: '貳元貳分',
	},
	{
		input: 2.2,
		expect: '貳元貳角',
	},
	{
		input: 1001,
		expect: '壹仟零壹元正',
	},
	{
		input: 1010,
		expect: '壹仟零壹拾元正',
	},
	{
		input: 10000,
		expect: '壹萬元正',
	},
	{
		input: 10001,
		expect: '壹萬零壹元正',
	},
	{
		input: 10010,
		expect: '壹萬零壹拾元正',
	},
	{
		input: 10100,
		expect: '壹萬零壹佰元正',
	},
	{
		input: 11001,
		expect: '壹萬壹仟零壹元正',
	},
	{
		input: 11011,
		expect: '壹萬壹仟零壹拾壹元正',
	},
	{
		input: 10101,
		expect: '壹萬零壹佰零壹元正',
	},
	{
		input: 100101,
		expect: '拾萬零壹佰零壹元正',
	},
	{
		input: 1001010,
		expect: '壹佰萬壹仟零壹拾元正',
	},
	{
		input: 10001010,
		expect: '壹仟萬壹仟零壹拾元正',
	},
	{
		input: 100000000,
		expect: '壹億元正',
	},
	{
		input: 100001010,
		expect: '壹億零壹仟零壹拾元正',
	},
	{
		input: 1000000000001001,
		expect: '壹仟兆零壹仟零壹元正',
	},
	{
		input: '1000000000000001001',
		expect: '壹佰京零壹仟零壹元正',
	},
];
