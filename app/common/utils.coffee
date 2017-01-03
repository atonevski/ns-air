constants = require './const'
http = require 'http'

levelClass = (par, val) ->
  val = (+val)
  params = constants.parameters[par]
  if params.levels.good.low <= val < params.levels.good.high
    'value good'
  else if params.levels.moderate.low <= val < params.levels.moderate.high
    'value moderate'
  else if params.levels.sensitive.low <= val < params.levels.sensitive.high
    'value sensitive'
  else if params.levels.unhealthy.low <= val < params.levels.unhealthy.high
    'value unhealthy'
  else if params.levels.veryUnhealthy.low <= val < params.levels.veryUnhealthy.high
    'value very-unhealthy'
  else if params.levels.hazardous.low <= val
    'value hazardous'
exports.levelClass = levelClass

# datetime to mk format dd.mm.yyyy hh:mm
dtToMK = (s) ->
  "#{ s[6..7] }.#{ s[4..5] }.#{ s[0..3] } #{ s[9..10] }:00"

# adjusts raw measurements
adjustMeasurements = (msr) ->
  newm =
    parameter:  msr.parameter
    stations:   msr.stations

  tms = Object.keys(msr.measurements).sort()
  stations = msr.stations
  arr = [ ]

  for idx, tm of tms
    m =
      time: dtToMK(tm)
      index: idx
      for:  [ ]
    for index, station of stations
      val = msr.measurements[tm][station]
      m.for.push {
          station: station,
          value: val
          index: index
          levelClass: levelClass(msr.parameter, val)
      }

    arr.push m

  newm.measurements = arr
  newm

#
exports.getMeasurements = (params) ->
  defs =
    station:        'SkopjeRegion'
    parameter:      'PM10'
    timeMode:       'Day'
    date:           (new Date()).toISOString()[0..9]
    drawBackground: false
    time:           Date.now()
    language:       'mk'

  # merge params with defaults
  for k, v of params
    defs[k] = v

  console.log "Params: ", JSON.stringify(defs)

  url = constants.MAKE_GRAPH_PATH +
        "?graph=StationLineGraph&station=#{ defs.station }" +
        "&parameter=#{ defs.parameter }&endDate=#{ defs.date }" +
        "&timeMode=#{ defs.timeMode }" +
        "&background=#{ defs.drawBackground }" +
        "&i=#{ defs.time }&language=#{ defs.language }"

  # get and save response
  http.getJSON url
    .then (res) ->
      console.log 'Loading JSON successful'
      res = adjustMeasurements res
      res.station = defs.station
      res
    , (err) ->
      console.log "Error loadind JSON: #{ err }"
      null
