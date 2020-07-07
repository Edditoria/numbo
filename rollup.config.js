/*jshint esversion: 6 */

/**
 * This file compiles Coffeescript files in <src/*.coffee>
 *               to UMD Javascript files in <bundles/*.js>.
 */

import packageJson from './package.json';
import babel from '@rollup/plugin-babel';
import coffee from 'rollup-plugin-coffee-script';

const packageName = packageJson.name;
const resolveExt = ['.coffee', '.litcoffee', '.mjs', 'js'];

function createConfig(file) {
	return {
		input: file.input,
		output: {
			file: file.output,
			format: 'umd',
			name: packageName
		},
		/* #todo:
		Evaluate the usage of this flagged option
		This is to overcome the error "`this` has been rewritten to `undefined`"
		in process of compiling numbo.coffee */
		context: 'this',
		plugins: [
			coffee(),
			babel({
				babelrc: false,
				presets: ['@babel/env'],
				babelHelpers: 'bundled',
				exclude: 'node_modules/**',
				extensions: resolveExt
			})
		]
	};
}

const files = [
	{
		input: 'src/numbo.coffee',
		output: 'bundles/numbo.js'
	}, {
		input: 'src/en-us.coffee',
		output: 'bundles/numbo.en-us.js'
	}, {
		input: 'src/zh-tw.coffee',
		output: 'bundles/numbo.zh-tw.js'
	}, {
		input: 'src/zh-cn.coffee',
		output: 'bundles/numbo.zh-cn.js'
	}
];
const configs = files.map(file => createConfig(file));

export default configs;
