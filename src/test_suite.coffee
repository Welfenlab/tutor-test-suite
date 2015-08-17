

module.exports =
  # Gets the names of all tests
  extractTestNames: (allTests, registerTest) ->
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

  # Defines the tests via it
  itTests: (result, allResults) ->
    prepare: (code, runner) ->
      """
      var it = (function(){
        var __it_index = 0;
        return function(name, fn) {
          try {
            fn();
            application.remote.pass(__it_index);
          } catch (e) {
            application.remote.fail(__it_index, {isException: true, exception: e});
          }
          __it_index++;
        }
      })();
      #{code}
      """
    api: (code, runner, elem)->
      passed = 0
      failed = 0
      pass: (idx) -> passed++; result null, idx, elem
      fail: (idx, error) -> failed++; result error, idx, elem
      finished: -> allResults null, passed, failed
      failed: (e)-> allResults e, 0, -1

  # simply logs the final test itself
  debugLog:
    prepare: (code) -> code
    api: (code) ->
      failed: (e)->
        console.log "error \"#{e}\" in "
        console.log code
