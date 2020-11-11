import enUSAmount from './en-us.amount.coffee'
import enUSCheque from './en-us.cheque.coffee'
import enUSNumber from './en-us.number.coffee'
import zhTWAmount from './zh-tw.amount.coffee'
import zhTWCheque from './zh-tw.cheque.coffee'
import zhTWNumber from './zh-tw.number.coffee'
import zhCNAmount from './zh-cn.amount.coffee'
import zhCNCheque from './zh-cn.cheque.coffee'
import zhCNNumber from './zh-cn.number.coffee'

###*
@typedef {Object} Data - A JSON-like series of test data in structure of data[lang][type][testObj...]
@property {Object.<Lang>.<Type>.<string|number>} input - Test input arg for running numbo()
@property {Object.<Lang>.<Type>.<?string>} expect - Expected result for running numbo()
@typedef {Object} Lang - One of { enUS, zhTW, zhCN } as property of Data
@typedef {Object} Type - One of { amount, cheque, number } as property of Lang
###

export default {
	enUS:
		amount: enUSAmount
		cheque: enUSCheque
		number: enUSNumber
	zhTW:
		amount: zhTWAmount
		cheque: zhTWCheque
		number: zhTWNumber
	zhCN:
		amount: zhCNAmount
		cheque: zhCNCheque
		number: zhCNNumber
}
