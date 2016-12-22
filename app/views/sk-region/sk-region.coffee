Observable = require("data/observable").Observable
utils = require '../../common/utils'

createViewModel = () ->
  viewModel = new Observable()
  viewModel.measurements = []
  viewModel.getMeasurements = (res) ->
    console.log 'Got measurements'
    @set 'measurements', res.marr
    @set 'parameter', res.parameter
    @set 'stations', res.stations

  utils.getMeasurements { station: 'SkopjeRegion' }
    .then (res) ->
      console.log 'Finally getting measurements'
      console.log JSON.stringify(res)
      viewModel.getMeasurements res
      console.log 'Here are the measurements: ', JSON.stringify(res)
  viewModel

exports.pageLoaded = (args) ->
  page = args.object
  console.log "Here we'll load JSON data"
  page.bindingContext = createViewModel()
