var Observable, constants, padz;

constants = require('../../common/const');

Observable = require("data/observable").Observable;

padz = function(n) {
  if (n < 10) {
    return '0' + n;
  } else {
    return n.toString();
  }
};

exports.createViewModel = function() {
  var viewModel;
  viewModel = new Observable();
  viewModel.date = {
    year: (new Date()).getFullYear(),
    month: (new Date()).getMonth() + 1,
    day: (new Date()).getDate(),
    maxDate: new Date(),
    minDate: new Date(2015, 1, 1)
  };
  viewModel.collapseParameters = true;
  viewModel.toggleCollapseParameters = function() {
    return this.set('collapseParameters', !this.collapseParameters);
  };
  viewModel.collapseDate = true;
  viewModel.toggleCollapseDate = function() {
    return this.set('collapseDate', !this.collapseDate);
  };
  viewModel.stationsMK = Object.keys(constants.stations).map(function(e) {
    return constants.stations[e].name;
  });
  viewModel.stationsKeys = Object.keys(constants.stations);
  viewModel.stations = {
    items: viewModel.stationsMK,
    selectedIndex: 2
  };
  viewModel.parameters = {
    items: Object.keys(constants.parameters),
    selectedIndex: 2
  };
  viewModel.onStationChange = function() {
    return console.log("station change, idx: " + this.stations.selectedIndex);
  };
  viewModel.onTap = function() {
    var Toast, application, frame, navigationEntry;
    application = require('application');
    Toast = android.widget.Toast;
    Toast.makeText(application.android.context, "Station: " + constants.stations[this.stationsKeys[this.stations.selectedIndex]].name + "\n\nParameter: " + constants.parameters[this.parameters.items[this.parameters.selectedIndex]].name, Toast.LENGTH_LONG).show();
    frame = require('ui/frame');
    navigationEntry = {
      moduleName: 'views/sk-region/sk-region',
      animated: false,
      context: {
        station: this.stationsKeys[this.stations.selectedIndex],
        parameter: this.parameters.items[this.parameters.selectedIndex],
        date: this.date.year + "-" + (padz(this.date.month)) + "-" + (padz(this.date.day))
      }
    };
    return frame.topmost().navigate(navigationEntry);
  };
  return viewModel;
};
