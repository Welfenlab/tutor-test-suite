

module.exports = (callbacks) ->
  api: (code, runner, elem)->
    passed = 0
    failed = 0
    tests = []
    remote:
      registerTest: (name) -> tests.push name; callbacks.registerTest? name, elem
      pass: (idx) -> passed++; callbacks.testResult null, idx, elem
      fail: (idx, error) -> failed++; callbacks.testResult error, idx, elem
      finished: (error) -> callbacks.allResults error, passed, tests.length - passed
      failed: (e)-> callbacks.allResults e, 0, tests.length
    snippets:
      it: """(function(){
        var __it_index = 0;
        return function(name, fn) {
          registerTest(name, 'it("'+name+'" + fn.toString() + ')';
          try {
            fn();
            pass(name);
          } catch (e) {
            if(typeof e == "string")
              fail(name, {isException: true, exception: e});
            else if (typeof(e.message) !== 'undefined')
              fail(name, {isException: true, exception: e.message});
            else
              fail(name, {isException: true, exception: "unkown error"});
          }
          __it_index++;
        }
      })()""";