Observable = require("data/observable").Observable
utils = require '../../common/utils'
constants = require '../../common/const'
layout = require 'ui/layouts/grid-layout'

require 'nativescript-dom'

createViewModel = (page) ->
  viewModel = new Observable()
  viewModel.isLoaded = no
  viewModel.measurements = []

  viewModel.getMeasurements = (res) ->
    console.log 'Got measurements'
    @set 'measurements', res.measurements
    @set 'parameter', res.parameter
    @set 'stations', res.stations
    @set 'station', constants.stations[res.station].name
    @set 'isLoaded', yes
    @set 'stationsMK', @buildStationsMK()
    @set 'header', @buildHeader()
    # @set 'stars', (@stations.map((e) -> '*')).join(', ')

    # fix header column width
    hel = page.getViewById 'header-id'
    hel.removeColumns()
    hel.addColumn new layout.ItemSpec(70, layout.GridUnitType.pixel)
    for s in @stations
      hel.addColumn new layout.ItemSpec(1, layout.GridUnitType.star)

    rows = page.getElementsByClassName 'gl-row'
    for r in rows
      r.removeColumns()
      for s in @stations
        r.addColumn new layout.ItemSpec(1, layout.GridUnitType.star)
    # finally set page is loaded
    # @set 'isLoaded', yes

  viewModel.buildStationsMK = () ->
    h = @stations.map (s) -> constants.stations[s].name
    h.join(', ')

  viewModel.buildHeader = () ->
    h = @stations.map (s) -> constants.stations[s].name
    a = ['време'].concat(h).map (e, i) -> { title: e, index: i }
    console.log JSON.stringify(a)
    a

  viewModel.columnWidths = () ->
    s = ['70']
    .concat(@stations.map (e) -> '*')
    .join ', '
    console.log s
    s

  utils.getMeasurements station: page.navigationContext.station
  , parameter: page.navigationContext.parameter
  , date: page.navigationContext.date
    .then (res) ->
      viewModel.getMeasurements res

  viewModel

exports.pageLoaded = (args) ->
  page = args.object
  page.bindingContext = createViewModel(page)
  console.log "Navigation Context: #{ JSON.stringify page.navigationContext }"
