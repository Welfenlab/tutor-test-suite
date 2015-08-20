
_ = require 'lodash'

concat = (a,b) -> a + b

module.exports = (allTests, registerTest) ->
  prepare: (code, runner, elem) ->
    tests = []
    decl = _(["it"]).chain()
      .map (tn) -> "var #{tn} = function(name, fn) { registerTest(name); };"
      .reduce concat, ""
      .value()
    runner.run """
      #{decl}
      #{code}
      finished();
      """,
      remote:
        registerTest: (name) -> tests.push name; registerTest? name, elem
        finished: -> allTests? tests, elem
      links: ["registerTest", "finished"]
    return code
