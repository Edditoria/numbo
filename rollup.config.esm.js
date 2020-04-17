/*jshint esversion: 6 */

/**
 * This file compiles Coffeescript files in <src/*.coffee>
 *               to ESM Javascript files in <esm/*.mjs>.
 * Requires Node >= 10.10.0 to use "withFileTypes" option.
 */

import packageJson from './package.json';
import fs from 'fs';
import coffee from 'rollup-plugin-coffee-script';
import esformatter from 'rollup-plugin-esformatter';

const packageName = packageJson.name;
const resolveExt = ['.coffee', '.litcoffee', '.mjs', 'js'];
const indent = '\t'; // '  ' or '\t'


/**
 * Get file list in a directory. Then,
 * create a list of input and output paths for Rollup.
 * @param {string} dir - Directory name, e.g. 'src', 'src/utils'
 * @return {Array.<{input: String, output: String}>}
 */
function createFileList(dir) {
	let dirname = dir.replace(/^(src)/, '') + '/'; // e.g. '/utils/', '/'
	let fileList = fs.readdirSync(dir, {withFileTypes: true})
		.filter(file => !file.isDirectory())
		.map(file => {
			let filename = file.name.replace(/(\.coffee)$/, '');
			let fileInfo = {};
			fileInfo.input = `${dir}/${file.name}`;
			fileInfo.output = `esm${dirname}${filename}.mjs`;
			return fileInfo;
		});
	return fileList;
}

/**
 * Create Rollup config object that compile src/*.coffee to esm/*.mjs
 * @param {Object} - Each file object in file list created by createFileList()
 * @return {Object} - Required by Rollup
 */
function createConfig(file) {
	return {
		input: file.input,
		output: {
			file: file.output,
			format: 'es',
			indent: indent
		},
		plugins: [
			coffee(),
			esformatter({ indent: { value: indent } })
		]
	};
}


const files = createFileList('src/utils');
const config = files.map(file => createConfig(file));

export default config;
