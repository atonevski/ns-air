var Observable, constants, createViewModel, layout, utils;

Observable = require("data/observable").Observable;

utils = require('../../common/utils');

constants = require('../../common/const');

layout = require('ui/layouts/grid-layout');

require('nativescript-dom');

createViewModel = function(page) {
  var viewModel;
  viewModel = new Observable();
  viewModel.isLoaded = false;
  viewModel.measurements = [];
  viewModel.getMeasurements = function(res) {
    var hel, j, k, len, len1, r, ref, results, rows, s;
    console.log('Got measurements');
    this.set('measurements', res.measurements);
    this.set('parameter', res.parameter);
    this.set('stations', res.stations);
    this.set('station', constants.stations[res.station].name);
    this.set('isLoaded', true);
    this.set('stationsMK', this.buildStationsMK());
    this.set('header', this.buildHeader());
    hel = page.getViewById('header-id');
    hel.removeColumns();
    hel.addColumn(new layout.ItemSpec(70, layout.GridUnitType.pixel));
    ref = this.stations;
    for (j = 0, len = ref.length; j < len; j++) {
      s = ref[j];
      hel.addColumn(new layout.ItemSpec(1, layout.GridUnitType.star));
    }
    rows = page.getElementsByClassName('gl-row');
    results = [];
    for (k = 0, len1 = rows.length; k < len1; k++) {
      r = rows[k];
      r.removeColumns();
      results.push((function() {
        var l, len2, ref1, results1;
        ref1 = this.stations;
        results1 = [];
        for (l = 0, len2 = ref1.length; l < len2; l++) {
          s = ref1[l];
          results1.push(r.addColumn(new layout.ItemSpec(1, layout.GridUnitType.star)));
        }
        return results1;
      }).call(this));
    }
    return results;
  };
  viewModel.buildStationsMK = function() {
    var h;
    h = this.stations.map(function(s) {
      return constants.stations[s].name;
    });
    return h.join(', ');
  };
  viewModel.buildHeader = function() {
    var a, h;
    h = this.stations.map(function(s) {
      return constants.stations[s].name;
    });
    a = ['време'].concat(h).map(function(e, i) {
      return {
        title: e,
        index: i
      };
    });
    console.log(JSON.stringify(a));
    return a;
  };
  viewModel.columnWidths = function() {
    var s;
    s = ['70'].concat(this.stations.map(function(e) {
      return '*';
    })).join(', ');
    console.log(s);
    return s;
  };
  utils.getMeasurements({
    station: page.navigationContext.station,
    parameter: page.navigationContext.parameter,
    date: page.navigationContext.date
  }).then(function(res) {
    return viewModel.getMeasurements(res);
  });
  return viewModel;
};

exports.pageLoaded = function(args) {
  var page;
  page = args.object;
  page.bindingContext = createViewModel(page);
  return console.log("Navigation Context: " + (JSON.stringify(page.navigationContext)));
};
