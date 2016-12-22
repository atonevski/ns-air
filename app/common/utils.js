var constants, dtToMK, http, measurementsToArray;

constants = require('./const');

http = require('http');

exports.levelClass = function(par, val) {
  var params;
  if (constants.parameters[par] == null) {
    throw "Invalid parameter " + par;
  }
  val = +val;
  params = constants.parameters[par];
  if ((params.level.good.low <= val && val < params.level.good.high)) {
    return 'good';
  } else if ((params.level.moderate.low <= val && val < params.level.moderate.high)) {
    return 'moderate';
  } else if ((params.level.sensitive.low <= val && val < params.level.sensitive.high)) {
    return 'sensitive';
  } else if ((params.level.unhealthy.low <= val && val < params.level.unhealthy.high)) {
    return 'unhealthy';
  } else if ((params.level.veryUnhealthy.low <= val && val < params.level.veryUnhealthy.high)) {
    return 'very-unhealthy';
  } else if (params.level.hazardous.low <= val) {
    return 'veryUnhealthy';
  }
};

dtToMK = function(s) {
  return s.slice(6, 8) + "." + s.slice(4, 6) + "." + s.slice(0, 4) + " " + s.slice(9, 11) + ":00";
};

measurementsToArray = function(m) {
  var arr, i, k, keys, len;
  keys = Object.keys(m).sort();
  arr = [];
  for (i = 0, len = keys.length; i < len; i++) {
    k = keys[i];
    arr.push({
      time: dtToMK(k),
      "for": m[k]
    });
  }
  return arr;
};

exports.getMeasurements = function(params) {
  var defs, k, url, v;
  defs = {
    station: 'SkopjeRegion',
    parameter: 'PM10',
    timeMode: 'Day',
    date: (new Date()).toISOString().slice(0, 10),
    drawBackground: false,
    time: Date.now(),
    language: 'mk'
  };
  for (k in params) {
    v = params[k];
    defs[k] = v;
  }
  console.log("Params: ", JSON.stringify(defs));
  url = constants.MAKE_GRAPH_PATH + ("?graph=StationLineGraph&station=" + defs.station) + ("&parameter=" + defs.parameter + "&endDate=" + defs.date) + ("&timeMode=" + defs.timeMode) + ("&background=" + defs.drawBackground) + ("&i=" + defs.time + "&language=" + defs.language);
  console.log("url: ", url);
  return http.getJSON(url).then(function(res) {
    console.log('Loading JSON successful');
    res.marr = measurementsToArray(res.measurements);
    delete res.measurements;
    return res;
  }, function(err) {
    console.log("Error loadind JSON: " + err);
    return null;
  });
};
