/*jshint esversion: 6 */

/**
 * This file compiles Coffeescript files in <src/*.coffee>
 *               to UMD Javascript files in <bundles/*.js>.
 */

import packageJson from './package.json';
import babel from '@rollup/plugin-babel';
import coffee from 'rollup-plugin-coffee-script';
import { terser } from "rollup-plugin-terser";
import banner from 'rollup-plugin-banner';

const testMode = false;
const packageName = packageJson.name;
const resolveExt = ['.coffee', '.litcoffee', '.mjs', 'js'];

function getTerserOptions(testMode) {
	return {
		ecma: 5,
		compress: false,
		mangle: false,
		keep_classnames: true,
		keep_fnames: true,
		output: {
			beautify: testMode,
			comments: testMode,
			indent_level: 2
		}
	};
}

function createConfig(file) {
	return {
		input: file.input,
		output: {
			file: file.output,
			format: 'umd',
			name: packageName,
			compact: true
		},
		/* #todo:
		Evaluate the usage of this flagged option
		This is to overcome the error "`this` has been rewritten to `undefined`"
		in process of compiling index.coffee */
		context: 'this',
		plugins: [
			coffee(),
			babel({
				babelrc: false,
				presets: [
					[
						'@babel/preset-env',
						{ targets: { ie: "9", node: "4" } }
					]
				],
				babelHelpers: 'bundled',
				exclude: 'node_modules/**',
				extensions: resolveExt
			}),
			terser(getTerserOptions(testMode)),
			banner({ file: 'src/index.head.txt'})
		]
	};
}

const files = [
	{
		input: 'src/index.coffee',
		output: 'bundles/numbo.min.js'
	}, {
		input: 'src/en-us.coffee',
		output: 'bundles/numbo.en-us.min.js'
	}, {
		input: 'src/zh-tw.coffee',
		output: 'bundles/numbo.zh-tw.min.js'
	}, {
		input: 'src/zh-cn.coffee',
		output: 'bundles/numbo.zh-cn.min.js'
	}, {
		input: 'src/index.coffee',
		output: 'docs/assets/js/numbo.min.js'
	}
];
const configs = files.map(file => createConfig(file));

// Add test-bundles to configs
configs.push({
	input: 'src/test/test-bundles.coffee',
	output: {
		file: 'test/test-bundles.js',
		format: 'cjs',
		// name: packageName
	},
	// context: 'this',
	plugins: [
		coffee()
	]
});

// Add all-data.js to configs
configs.push({
	input: 'src/test/data/all-data.coffee',
	output: {
		file: 'test/data/all-data.js',
		format: 'cjs',
		// name: packageName,
		exports: 'auto'
	},
	// context: 'this',
	plugins: [
		coffee()
	]
});

// Add all-tools.js to configs
configs.push({
	input: 'src/test/shared/all-tools.coffee',
	output: {
		file: 'test/shared/all-tools.js',
		format: 'cjs',
		// name: packageName,
		exports: 'auto'
	},
	// context: 'this',
	plugins: [
		coffee()
	]
});

export default configs;
