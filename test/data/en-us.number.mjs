export default [
	{
		input: 0,
		expect: 'zero',
	},
	{
		input: 1,
		expect: 'one',
	},
	{
		input: 1.01,
		expect: 'one point zero one',
	},
	{
		input: 1.1,
		expect: 'one point one',
	},
	{
		input: 2,
		expect: 'two',
	},
	{
		input: 2.01,
		expect: 'two point zero one',
	},
	{
		input: 2.1,
		expect: 'two point one',
	},
	{
		input: 9,
		expect: 'nine',
	},
	{
		input: 10,
		expect: 'ten',
	},
	{
		input: 11,
		expect: 'eleven',
	},
	{
		input: 19,
		expect: 'nineteen',
	},
	{
		input: 20,
		expect: 'twenty',
	},
	{
		input: 21,
		expect: 'twenty-one',
	},
	{
		input: 88,
		expect: 'eighty-eight',
	},
	{
		input: 100,
		expect: 'one hundred',
	},
	{
		input: 101,
		expect: 'one hundred and one',
	},
	{
		input: 180,
		expect: 'one hundred and eighty',
	},
	{
		input: 888,
		expect: 'eight hundred and eighty-eight',
	},
	{
		input: 0.01,
		expect: 'zero point zero one',
	},
	{
		input: 0.1,
		expect: 'zero point one',
	},
	{
		input: 0.5,
		expect: 'zero point five',
	},
	{
		input: 0.00001,
		expect: 'zero point zero zero zero zero one',
	},
	{
		input: 1.00001,
		expect: 'one point zero zero zero zero one',
	},
	{
		input: 2.00001,
		expect: 'two point zero zero zero zero one',
	},
	{
		input: 3.00001,
		expect: 'three point zero zero zero zero one',
	},
	{
		input: 1000,
		expect: 'one thousand',
	},
	{
		input: 1000000,
		expect: 'one million',
	},
	{
		input: 1234567.89,
		expect:
			'one million two hundred and thirty-four thousand five hundred and sixty-seven point eight nine',
	},
	{
		input: '123.9940',
		expect: 'one hundred and twenty-three point nine nine four',
	},
	{
		input: '123.9950',
		expect: 'one hundred and twenty-three point nine nine five',
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
		expect: 'zero',
	},
	{
		input: '0.1',
		expect: 'zero point one',
	},
	{
		input: '00000123.4500000',
		expect: 'one hundred and twenty-three point four five',
	},
	{
		input: '1e+100',
		expect: 'Ding! One Google... Oops... One Googol!!',
	},
];
