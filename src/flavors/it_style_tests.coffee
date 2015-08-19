

module.exports = (result, allResults) ->
  api: (code, runner, elem)->
    passed = 0
    failed = 0
    remote:
      pass: (idx) -> passed++; result null, idx, elem
      fail: (idx, error) -> failed++; result error, idx, elem
      finished: -> allResults null, passed, failed
      failed: (e)-> allResults e, 0, -1
    internal:
      it: """(function(){
          var __it_index = 0;
          return function(name, fn) {
            try {
              fn();
              pass(__it_index);
            } catch (e) {
              fail(__it_index, {isException: true, exception: e});
            }
            __it_index++;
          }
        })()"""
