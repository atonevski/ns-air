constants = require '../../common/const'
Observable = require("data/observable").Observable

padz = (n) -> if n < 10 then '0' + n else n.toString()

exports.createViewModel = () ->
  viewModel = new Observable()
  viewModel.date =
    # date:   new Date()
    year:   (new Date()).getFullYear()
    month:  (new Date()).getMonth() + 1
    day:    (new Date()).getDate()
    maxDate: new Date()
    minDate: new Date(2015, 1, 1)

  viewModel.collapseParameters = yes
  viewModel.toggleCollapseParameters = () ->
    @set 'collapseParameters',  ! @collapseParameters

  viewModel.collapseDate = yes
  viewModel.toggleCollapseDate = () ->
    @set 'collapseDate',  ! @collapseDate

  viewModel.stationsMK = Object.keys(constants.stations).map (e) ->
                            constants.stations[e].name
  viewModel.stationsKeys = Object.keys constants.stations

  viewModel.stations =
      items: viewModel.stationsMK
      selectedIndex: 2
  viewModel.parameters =
      items: Object.keys constants.parameters
      selectedIndex: 2

  viewModel.onStationChange = () ->
    console.log "station change, idx: #{ @stations.selectedIndex }"

  viewModel.onTap = () ->
    application = require 'application'
    Toast = android.widget.Toast
    Toast.makeText application.android.context,
          """
          Station: #{ constants.stations[@stationsKeys[@stations.selectedIndex]].name }\n
          Parameter: #{ constants.parameters[@parameters.items[@parameters.selectedIndex]].name }
          """,
          Toast.LENGTH_LONG
      .show()

    frame = require 'ui/frame'

    # frame.topmost().navigate('views/sk-region/sk-region')
    # since we are pasing arguments to a view
    navigationEntry =
      moduleName: 'views/sk-region/sk-region'
      animated: false
      context:
        station: @stationsKeys[@stations.selectedIndex]
        parameter: @parameters.items[@parameters.selectedIndex]
        date: "#{ @date.year }-#{ padz @date.month }-#{ padz @date.day }"

    frame.topmost().navigate navigationEntry


  viewModel
