

module.exports =
  # Defines the test environment via it
  itTests: require './flavors/it_style_tests'
  
  # gathers JS sources for tests
  jsTests: require './flavors/jscode_tests'

  # simply logs the final test itself
  debugLog:
    api: (code) ->
      remote:
        failed: (e)->
          console.log "error \"#{e}\" in "
          console.log code

  # prepend a debbuger command to stop in sandbox
  debugCode:
    prepare: (code) -> "debugger;\n#{code}"
