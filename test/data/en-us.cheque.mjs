export default [
	{
		input: 0,
		expect: 'Null',
	},
	{
		input: 1,
		expect: 'One Dollar and No Cent Only',
	},
	{
		input: 1.01,
		expect: 'One Dollar and One Cent Only',
	},
	{
		input: 1.1,
		expect: 'One Dollar and Ten Cents Only',
	},
	{
		input: 2,
		expect: 'Two Dollars and No Cent Only',
	},
	{
		input: 2.01,
		expect: 'Two Dollars and One Cent Only',
	},
	{
		input: 2.1,
		expect: 'Two Dollars and Ten Cents Only',
	},
	{
		input: 9,
		expect: 'Nine Dollars and No Cent Only',
	},
	{
		input: 10,
		expect: 'Ten Dollars and No Cent Only',
	},
	{
		input: 11,
		expect: 'Eleven Dollars and No Cent Only',
	},
	{
		input: 19,
		expect: 'Nineteen Dollars and No Cent Only',
	},
	{
		input: 20,
		expect: 'Twenty Dollars and No Cent Only',
	},
	{
		input: 21,
		expect: 'Twenty-one Dollars and No Cent Only',
	},
	{
		input: 88,
		expect: 'Eighty-eight Dollars and No Cent Only',
	},
	{
		input: 100,
		expect: 'One Hundred Dollars and No Cent Only',
	},
	{
		input: 101,
		expect: 'One Hundred One Dollars and No Cent Only',
	},
	{
		input: 180,
		expect: 'One Hundred Eighty Dollars and No Cent Only',
	},
	{
		input: 888,
		expect: 'Eight Hundred Eighty-eight Dollars and No Cent Only',
	},
	{
		input: 0.01,
		expect: 'One Cent Only',
	},
	{
		input: 0.1,
		expect: 'Ten Cents Only',
	},
	{
		input: 0.5,
		expect: 'Fifty Cents Only',
	},
	{
		input: 0.00001,
		expect: 'One Cent Only', // { 'input': .00001, 'expect': 'Null' }
	},
	{
		input: 1.00001,
		expect: 'One Dollar and One Cent Only', // { 'input': 1.00001, 'expect': 'One Dollar and No Cent Only' }
	},
	{
		input: 2.00001,
		expect: 'Two Dollars and One Cent Only', // { 'input': 2.00001, 'expect': 'Two Dollars and No Cent Only' }
	},
	{
		input: 3.00001,
		expect: 'Three Dollars and One Cent Only', // { 'input': 3.00001, 'expect': 'Three Dollars and No Cent Only' }
	},
	{
		input: 1000,
		expect: 'One Thousand Dollars and No Cent Only',
	},
	{
		input: 1000000,
		expect: 'One Million Dollars and No Cent Only',
	},
	{
		input: 1234567.89,
		expect:
			'One Million Two Hundred Thirty-four Thousand Five Hundred Sixty-seven Dollars and Eighty-nine Cents Only',
	},
	{
		input: '123.9940',
		expect: 'One Hundred Twenty-four Dollars and No Cent Only',
	},
	{
		input: '123.9950',
		expect: 'One Hundred Twenty-four Dollars and No Cent Only',
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
		expect: 'Null',
	},
	{
		input: '0.1',
		expect: 'Ten Cents Only',
	},
	{
		input: '00000123.4500000',
		expect: 'One Hundred Twenty-three Dollars and Forty-five Cents Only',
	},
	{
		input: '1e+100',
		expect: 'Ding! One Google... Oops... One Googol!!',
	},
];
