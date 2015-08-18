
module.exports = (allTests, registerTest) ->
  prepare: (code, runner, elem) ->
    tests = []
    runner.run """
      var it = function(name, fn) {
        application.remote.registerTest(name);
      };
      #{code}
      application.remote.finished();
      """, 
      registerTest: (name) -> tests.push name; registerTest? name, elem
      finished: -> allTests? tests, elem
    return code
