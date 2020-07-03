export default [
	{ 'input': 0, 'expect': '零' }
	{ 'input': 1, 'expect': '一' }
	{ 'input': 1.01, 'expect': '一点零一' }
	{ 'input': 1.1, 'expect': '一点一' }
	{ 'input': 2, 'expect': '二' }
	{ 'input': 2.01, 'expect': '二点零一' }
	{ 'input': 2.1, 'expect': '二点一' }
	{ 'input': 9, 'expect': '九' }
	{ 'input': 10, 'expect': '十' }
	{ 'input': 11, 'expect': '十一' }
	{ 'input': 19, 'expect': '十九' }
	{ 'input': 20, 'expect': '二十' }
	{ 'input': 21, 'expect': '二十一' }
	{ 'input': 88, 'expect': '八十八' }
	{ 'input': 100, 'expect': '一百' }
	{ 'input': 101, 'expect': '一百零一' }
	{ 'input': 180, 'expect': '一百八十' }
	{ 'input': 888, 'expect': '八百八十八' }
	{ 'input': 0.01, 'expect': '零点零一' }
	{ 'input': 0.1, 'expect': '零点一' }
	{ 'input': .50, 'expect': '零点五' }
	{ 'input': .00001, 'expect': '零点零零零零一' }
	{ 'input': 1.00001, 'expect': '一点零零零零一' }
	{ 'input': 2.00001, 'expect': '二点零零零零一' }
	{ 'input': 3.00001, 'expect': '三点零零零零一' }
	{ 'input': 1000, 'expect': '一千' }
	{ 'input': 1000000, 'expect': '一百万' }
	{ 'input': 1234567.89, 'expect': '一百二十三万四千五百六十七点八九' }
	{ 'input': '123.9940', 'expect': '一百二十三点九九四' }
	{ 'input': '123.9950', 'expect': '一百二十三点九九五' }
	{ 'input': 'test a string', 'expect': null }
	{ 'input': '', 'expect': null }
	{ 'input': '0000000', 'expect': '零' }
	{ 'input': '0.1', 'expect': '零点一' }
	{ 'input': '00000123.4500000', 'expect': '一百二十三点四五' }
	{ 'input': '1e+100', 'expect': 'Ding! One Google... Oops... One Googol!!' }

	# specific tests for this language

	{ 'input': 2.02, 'expect': '二点零二' }
	{ 'input': 2.2, 'expect': '二点二' }
	{ 'input': 1001, 'expect': '一千零一' }
	{ 'input': 1010, 'expect': '一千零一十' }
	{ 'input': 10000, 'expect': '一万' }
	{ 'input': 10001, 'expect': '一万零一' }
	{ 'input': 10010, 'expect': '一万零一十' }
	{ 'input': 10100, 'expect': '一万零一百' }
	{ 'input': 11001, 'expect': '一万一千零一' }
	{ 'input': 11011, 'expect': '一万一千零一十一' }
	{ 'input': 10101, 'expect': '一万零一百零一' }
	{ 'input': 100101, 'expect': '十万零一百零一' }
	{ 'input': 1001010, 'expect': '一百万一千零一十' }
	{ 'input': 10001010, 'expect': '一千万一千零一十' }
	{ 'input': 100000000, 'expect': '一亿' }
	{ 'input': 100001010, 'expect': '一亿零一千零一十' }
	{ 'input': 1000000000001001, 'expect': '一千兆零一千零一' }
	{ 'input': '1000000000000001001', 'expect': '一百京零一千零一' }
]
