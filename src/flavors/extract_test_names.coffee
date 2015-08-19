
module.exports = (allTests, registerTest) ->
  prepare: (code, runner, elem) ->
    tests = []
    runner.run """
      var it = function(name, fn) {
        registerTest(name);
      };
      #{code}
      finished();
      """,
      remote:
        registerTest: (name) -> tests.push name; registerTest? name, elem
        finished: -> allTests? tests, elem
    return code
