

module.exports =
  # Gets the names of all tests
  extractTestNames: require './flavors/extract_test_names'

  # Defines the test environment via it
  itTests: require './flavors/it_style_tests'
  
  # gathers JS sources for tests
  jsTests: require './flavors/jscode_tests'

  # simply logs the final test itself
  debugLog:
    prepare: (code) -> code
    api: (code) ->
      failed: (e)->
        console.log "error \"#{e}\" in "
        console.log code
