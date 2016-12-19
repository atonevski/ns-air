MAKE_GRAPH_PATH = "http://airquality.moepp.gov.mk/graphs/site/pages/MakeGraph.php"

exports.pageLoaded = () ->
  console.log "Here we'll load JSON data"
  http = require 'http'
  url = MAKE_GRAPH_PATH +
      "?graph=StationLineGraph&station=SkopjeRegion" +
      "&parameter=PM10&endDate=#{ (new Date()).toISOString()[0..9] }" +
      "&timeMode=Day" +
      "&background=false" +
      "&i=#{ Date.now() }&language=mk"

  http.getJSON(url)
    .then (res) ->
      console.log 'Loading JSON successful'
      console.log JSON.stringify(res)
      null
    , (err) ->
      console.log "Error loadind JSON: #{ err }"
      null
  null
