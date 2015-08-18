

module.exports = (result, allResults) ->
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
