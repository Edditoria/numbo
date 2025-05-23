export default [
	{ 'input': 0, 'expect': '零元' },
	{ 'input': 1, 'expect': '壹元整' },
	{ 'input': 1.01, 'expect': '壹元壹分' },
	{ 'input': 1.1, 'expect': '壹元壹角' },
	{ 'input': 2, 'expect': '贰元整' },
	{ 'input': 2.01, 'expect': '贰元壹分' },
	{ 'input': 2.1, 'expect': '贰元壹角' },
	{ 'input': 9, 'expect': '玖元整' },
	{ 'input': 10, 'expect': '拾元整' },
	{ 'input': 11, 'expect': '拾壹元整' },
	{ 'input': 19, 'expect': '拾玖元整' },
	{ 'input': 20, 'expect': '贰拾元整' },
	{ 'input': 21, 'expect': '贰拾壹元整' },
	{ 'input': 88, 'expect': '捌拾捌元整' },
	{ 'input': 100, 'expect': '壹佰元整' },
	{ 'input': 101, 'expect': '壹佰零壹元整' },
	{ 'input': 180, 'expect': '壹佰捌拾元整' },
	{ 'input': 888, 'expect': '捌佰捌拾捌元整' },
	{ 'input': 0.01, 'expect': '壹分' },
	{ 'input': 0.1, 'expect': '壹角' },
	{ 'input': .50, 'expect': '伍角' },
	{ 'input': .00001, 'expect': '壹分' }, // { 'input': .00001, 'expect': '零元' }
	{ 'input': 1.00001, 'expect': '壹元壹分' }, // { 'input': 1.00001, 'expect': '壹元整' }
	{ 'input': 2.00001, 'expect': '贰元壹分' }, // { 'input': 2.00001, 'expect': '贰元整' }
	{ 'input': 3.00001, 'expect': '叁元壹分' }, // { 'input': 3.00001, 'expect': '叁元整' }
	{ 'input': 1000, 'expect': '壹仟元整' },
	{ 'input': 1000000, 'expect': '壹佰万元整' },
	{ 'input': 1234567.89, 'expect': '壹佰贰拾叁万肆仟伍佰陆拾柒元捌角玖分' },
	{ 'input': '123.9940', 'expect': '壹佰贰拾肆元整' },
	{ 'input': '123.9950', 'expect': '壹佰贰拾肆元整' },
	{ 'input': 'test a string', 'expect': null },
	{ 'input': '', 'expect': null },
	{ 'input': '0000000', 'expect': '零元' },
	{ 'input': '0.1', 'expect': '壹角' },
	{ 'input': '00000123.4500000', 'expect': '壹佰贰拾叁元肆角伍分' },
	{ 'input': '1e+100', 'expect': 'Ding! One Google... Oops... One Googol!!' },

	// specific tests for this language

	{ 'input': 2.02, 'expect': '贰元贰分' },
	{ 'input': 2.2, 'expect': '贰元贰角' },
	{ 'input': 1001, 'expect': '壹仟零壹元整' },
	{ 'input': 1010, 'expect': '壹仟零壹拾元整' },
	{ 'input': 10000, 'expect': '壹万元整' },
	{ 'input': 10001, 'expect': '壹万零壹元整' },
	{ 'input': 10010, 'expect': '壹万零壹拾元整' },
	{ 'input': 10100, 'expect': '壹万零壹佰元整' },
	{ 'input': 11001, 'expect': '壹万壹仟零壹元整' },
	{ 'input': 11011, 'expect': '壹万壹仟零壹拾壹元整' },
	{ 'input': 10101, 'expect': '壹万零壹佰零壹元整' },
	{ 'input': 100101, 'expect': '拾万零壹佰零壹元整' },
	{ 'input': 1001010, 'expect': '壹佰万壹仟零壹拾元整' },
	{ 'input': 10001010, 'expect': '壹仟万壹仟零壹拾元整' },
	{ 'input': 100000000, 'expect': '壹亿元整' },
	{ 'input': 100001010, 'expect': '壹亿零壹仟零壹拾元整' },
	{ 'input': 1000000000001001, 'expect': '壹仟兆零壹仟零壹元整' },
	{ 'input': '1000000000000001001', 'expect': '壹佰京零壹仟零壹元整' }
];
