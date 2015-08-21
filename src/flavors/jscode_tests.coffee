
_ = require 'lodash'

concat = (a,b) -> a + b

module.exports =
  prepare: (code, runner, elem, tokens) ->      
    testsCode = _(tokens).chain()
      .filter "info": "js"
      .pluck "content"
      .reduce concat, ""
      .value()
    return testsCode + "{};\n" + code
