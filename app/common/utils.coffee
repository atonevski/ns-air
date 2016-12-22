constants = require './const'
http = require 'http'

exports.levelClass = (par, val) ->
  throw "Invalid parameter #{ par }" unless constants.parameters[par]?
  val = (+val)
  params = constants.parameters[par]

  if params.level.good.low <= val < params.level.good.high
    'good'
  else if params.level.moderate.low <= val < params.level.moderate.high
    'moderate'
  else if params.level.sensitive.low <= val < params.level.sensitive.high
    'sensitive'
  else if params.level.unhealthy.low <= val < params.level.unhealthy.high
    'unhealthy'
  else if params.level.veryUnhealthy.low <= val < params.level.veryUnhealthy.high
    'very-unhealthy'
  else if params.level.hazardous.low <= val
    'veryUnhealthy'

# datetime to mk format dd.mm.yyyy hh:mm
dtToMK = (s) ->
  "#{ s[6..7] }.#{ s[4..5] }.#{ s[0..3] } #{ s[9..10] }:00"

# expects: m = measurements object
measurementsToArray = (m) ->
  keys = Object.keys(m).sort()
  arr = [ ]
  for k in keys
    arr.push { time: dtToMK(k), for: m[k] }

  arr

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

  console.log "url: ", url

  # get and save response
  http.getJSON url
    .then (res) ->
      console.log 'Loading JSON successful'
      res.marr = measurementsToArray res.measurements
      delete res.measurements
      # console.log JSON.stringify(res)
      res
    , (err) ->
      console.log "Error loadind JSON: #{ err }"
      null
# {
#   "parameter":"PM10",
#   "measurements":
#     {"20161220 09": {"Centar":"254.10","GaziBaba":"","Karpos":"250.96","Lisice":"333.63","Rektorat":"273.41","Mrsevci":"","Miladinovci":"146.09"},
#     "20161220 10":{"Centar":"243.44","GaziBaba":"380.10","Karpos":"279.04","Lisice":"201.42","Rektorat":"290.38","Mrsevci":"","Miladinovci":"106.13"},
#     "20161220 11":{"Centar":"226.87","GaziBaba":"223.63","Karpos":"222.28","Lisice":"250.11","Rektorat":"255.50","Mrsevci":"","Miladinovci":"133.10"},
#     "20161220 12":{"Centar":"199.79","GaziBaba":"268.84","Karpos":"176.13","Lisice":"292.25","Rektorat":"202.66","Mrsevci":"","Miladinovci":"149.83"},
#     "20161220 13":{"Centar":"248.22","GaziBaba":"247.48","Karpos":"168.18","Lisice":"275.85","Rektorat":"216.37","Mrsevci":"","Miladinovci":"129.18"},
#     "20161220 14":{"Centar":"244.10","GaziBaba":"313.63","Karpos":"245.53","Lisice":"229.66","Rektorat":"302.64","Mrsevci":"","Miladinovci":"144.50"},
#     "20161220 15":{"Centar":"263.12","GaziBaba":"294.17","Karpos":"271.02","Lisice":"236.16","Rektorat":"305.83","Mrsevci":"","Miladinovci":"133.41"},
#     "20161220 16":{"Centar":"232.93","GaziBaba":"366.71","Karpos":"311.56","Lisice":"299.17","Rektorat":"377.88","Mrsevci":"","Miladinovci":"187.06"},
#     "20161220 17":{"Centar":"165.72","GaziBaba":"475.37","Karpos":"342.31","Lisice":"493.05","Rektorat":"540.02","Mrsevci":"","Miladinovci":"316.34"},
#     "20161220 18":{"Centar":"212.59","GaziBaba":"462.13","Karpos":"494.65","Lisice":"559.61","Rektorat":"730.01","Mrsevci":"","Miladinovci":"209.83"},
#     "20161220 19":{"Centar":"214.13","GaziBaba":"530.64","Karpos":"554.43","Lisice":"640.69","Rektorat":"981.31","Mrsevci":"","Miladinovci":"188.59"},
#     "20161220 20":{"Centar":"286.89","GaziBaba":"750.24","Karpos":"568.75","Lisice":"811.42","Rektorat":"886.03","Mrsevci":"","Miladinovci":"154.56"},
#     "20161220 21":{"Centar":"367.50","GaziBaba":"817.40","Karpos":"548.13","Lisice":"640.70","Rektorat":"661.58","Mrsevci":"","Miladinovci":"93.76"},
#     "20161220 22":{"Centar":"370.62","GaziBaba":"444.54","Karpos":"516.42","Lisice":"680.14","Rektorat":"576.49","Mrsevci":"","Miladinovci":"97.83"},
#     "20161220 23":{"Centar":"408.22","GaziBaba":"636.42","Karpos":"521.68","Lisice":"868.55","Rektorat":"590.12","Mrsevci":"","Miladinovci":"69.18"},
#     "20161221 00":{"Centar":"362.37","GaziBaba":"520.66","Karpos":"448.59","Lisice":"972.74","Rektorat":"717.69","Mrsevci":"","Miladinovci":"55.46"},
#     "20161221 01":{"Centar":"133.83","GaziBaba":"447.64","Karpos":"199.76","Lisice":"640.60","Rektorat":"519.32","Mrsevci":"","Miladinovci":"49.56"},
#     "20161221 02":{"Centar":"219.80","GaziBaba":"418.38","Karpos":"129.49","Lisice":"463.42","Rektorat":"334.20","Mrsevci":"","Miladinovci":"46.94"},
#     "20161221 03":{"Centar":"219.03","GaziBaba":"290.24","Karpos":"268.03","Lisice":"234.23","Rektorat":"324.05","Mrsevci":"","Miladinovci":"40.99"},
#     "20161221 04":{"Centar":"156.44","GaziBaba":"84.29","Karpos":"211.60","Lisice":"94.63","Rektorat":"101.44","Mrsevci":"","Miladinovci":"38.85"},
#     "20161221 05":{"Centar":"166.15","GaziBaba":"78.90","Karpos":"180.05","Lisice":"68.63","Rektorat":"80.40","Mrsevci":"","Miladinovci":"43.00"},
#     "20161221 06":{"Centar":"131.87","GaziBaba":"72.06","Karpos":"140.30","Lisice":"71.39","Rektorat":"98.16","Mrsevci":"","Miladinovci":"47.52"},
#     "20161221 07":{"Centar":"81.71","GaziBaba":"116.46","Karpos":"111.63","Lisice":"102.70","Rektorat":"120.40","Mrsevci":"","Miladinovci":"51.46"},
#     "20161221 08":{"Centar":"87.38","GaziBaba":"95.04","Karpos":"137.06","Lisice":"158.16","Rektorat":"98.41","Mrsevci":"","Miladinovci":"55.45"},
#     "20161221 09":{"Centar":"","GaziBaba":"","Karpos":"","Lisice":"","Rektorat":"","Mrsevci":"","Miladinovci":""}},
#     "stations": ["Centar","GaziBaba","Karpos","Lisice","Rektorat","Mrsevci","Miladinovci"],
#     "measurements_length":25,
#     "filename":"..\/tmp\/StationLineGraph_Centar_GaziBaba_Karpos_Lisice_Rektorat_Mrsevci_Miladinovci_PM10_Day_1482307200_mk.png",
#     "graph_fastpath":1}
