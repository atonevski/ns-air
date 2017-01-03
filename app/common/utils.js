var adjustMeasurements, constants, dtToMK, http, levelClass;

constants = require('./const');

http = require('http');

levelClass = function(par, val) {
  var params;
  val = +val;
  params = constants.parameters[par];
  if ((params.levels.good.low <= val && val < params.levels.good.high)) {
    return 'value good';
  } else if ((params.levels.moderate.low <= val && val < params.levels.moderate.high)) {
    return 'value moderate';
  } else if ((params.levels.sensitive.low <= val && val < params.levels.sensitive.high)) {
    return 'value sensitive';
  } else if ((params.levels.unhealthy.low <= val && val < params.levels.unhealthy.high)) {
    return 'value unhealthy';
  } else if ((params.levels.veryUnhealthy.low <= val && val < params.levels.veryUnhealthy.high)) {
    return 'value very-unhealthy';
  } else if (params.levels.hazardous.low <= val) {
    return 'value hazardous';
  }
};

exports.levelClass = levelClass;

dtToMK = function(s) {
  return s.slice(6, 8) + "." + s.slice(4, 6) + "." + s.slice(0, 4) + " " + s.slice(9, 11) + ":00";
};

adjustMeasurements = function(msr) {
  var arr, idx, index, m, newm, station, stations, tm, tms, val;
  newm = {
    parameter: msr.parameter,
    stations: msr.stations
  };
  tms = Object.keys(msr.measurements).sort();
  stations = msr.stations;
  arr = [];
  for (idx in tms) {
    tm = tms[idx];
    m = {
      time: dtToMK(tm),
      index: idx,
      "for": []
    };
    for (index in stations) {
      station = stations[index];
      val = msr.measurements[tm][station];
      m["for"].push({
        station: station,
        value: val,
        index: index,
        levelClass: levelClass(msr.parameter, val)
      });
    }
    arr.push(m);
  }
  newm.measurements = arr;
  return newm;
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
  return http.getJSON(url).then(function(res) {
    console.log('Loading JSON successful');
    res = adjustMeasurements(res);
    res.station = defs.station;
    return res;
  }, function(err) {
    console.log("Error loadind JSON: " + err);
    return null;
  });
};
