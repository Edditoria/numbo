#!/usr/bin/env bash

echo "Compile coffeescript files..."
coffee --transpile --output ./lib/ --compile ./src/*.coffee
coffee --transpile --output ./docs/assets/js --compile ./src/*.coffee
coffee --transpile --output ./test/ --compile ./src/test/*.coffee
echo "Compile finish."
