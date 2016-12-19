var MAKE_GRAPH_PATH;

MAKE_GRAPH_PATH = "http://airquality.moepp.gov.mk/graphs/site/pages/MakeGraph.php";

exports.pageLoaded = function() {
  var http, url;
  console.log("Here we'll load JSON data");
  http = require('http');
  url = MAKE_GRAPH_PATH + "?graph=StationLineGraph&station=SkopjeRegion" + ("&parameter=PM10&endDate=" + ((new Date()).toISOString().slice(0, 10))) + "&timeMode=Day" + "&background=false" + ("&i=" + (Date.now()) + "&language=mk");
  http.getJSON(url).then(function(res) {
    console.log('Loading JSON successful');
    console.log(JSON.stringify(res));
    return null;
  }, function(err) {
    console.log("Error loadind JSON: " + err);
    return null;
  });
  return null;
};
