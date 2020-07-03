export default [
	{ 'input': 0, 'expect': '零' }
	{ 'input': 1, 'expect': '一' }
	{ 'input': 1.01, 'expect': '一點零一' }
	{ 'input': 1.1, 'expect': '一點一' }
	{ 'input': 2, 'expect': '二' }
	{ 'input': 2.01, 'expect': '二點零一' }
	{ 'input': 2.1, 'expect': '二點一' }
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
	{ 'input': 0.01, 'expect': '零點零一' }
	{ 'input': 0.1, 'expect': '零點一' }
	{ 'input': .50, 'expect': '零點五' }
	{ 'input': .00001, 'expect': '零點零零零零一' }
	{ 'input': 1.00001, 'expect': '一點零零零零一' }
	{ 'input': 2.00001, 'expect': '二點零零零零一' }
	{ 'input': 3.00001, 'expect': '三點零零零零一' }
	{ 'input': 1000, 'expect': '一千' }
	{ 'input': 1000000, 'expect': '一百萬' }
	{ 'input': 1234567.89, 'expect': '一百二十三萬四千五百六十七點八九' }
	{ 'input': '123.9940', 'expect': '一百二十三點九九四' }
	{ 'input': '123.9950', 'expect': '一百二十三點九九五' }
	{ 'input': 'test a string', 'expect': null }
	{ 'input': '', 'expect': null }
	{ 'input': '0000000', 'expect': '零' }
	{ 'input': '0.1', 'expect': '零點一' }
	{ 'input': '00000123.4500000', 'expect': '一百二十三點四五' }
	{ 'input': '1e+100', 'expect': 'Ding! One Google... Oops... One Googol!!' }

	# specific tests for this language

	{ 'input': 1001, 'expect': '一千零一' }
	{ 'input': 1010, 'expect': '一千零一十' }
	{ 'input': 10000, 'expect': '一萬' }
	{ 'input': 10001, 'expect': '一萬零一' }
	{ 'input': 10010, 'expect': '一萬零一十' }
	{ 'input': 10100, 'expect': '一萬零一百' }
	{ 'input': 11001, 'expect': '一萬一千零一' }
	{ 'input': 11011, 'expect': '一萬一千零一十一' }
	{ 'input': 10101, 'expect': '一萬零一百零一' }
	{ 'input': 100101, 'expect': '十萬零一百零一' }
	{ 'input': 1001010, 'expect': '一百萬一千零一十' }
	{ 'input': 10001010, 'expect': '一千萬一千零一十' }
	{ 'input': 100000000, 'expect': '一億' }
	{ 'input': 100001010, 'expect': '一億零一千零一十' }
	{ 'input': 1000000000001001, 'expect': '一千兆零一千零一' }
	{ 'input': '1000000000000001001', 'expect': '一百京零一千零一' }
]
