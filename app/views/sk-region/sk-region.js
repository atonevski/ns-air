var Observable, createViewModel, utils;

Observable = require("data/observable").Observable;

utils = require('../../common/utils');

createViewModel = function() {
  var viewModel;
  viewModel = new Observable();
  viewModel.measurements = [];
  viewModel.getMeasurements = function(res) {
    console.log('Got measurements');
    this.set('measurements', res.marr);
    this.set('parameter', res.parameter);
    return this.set('stations', res.stations);
  };
  utils.getMeasurements({
    station: 'SkopjeRegion'
  }).then(function(res) {
    console.log('Finally getting measurements');
    console.log(JSON.stringify(res));
    viewModel.getMeasurements(res);
    return console.log('Here are the measurements: ', JSON.stringify(res));
  });
  return viewModel;
};

exports.pageLoaded = function(args) {
  var page;
  page = args.object;
  console.log("Here we'll load JSON data");
  return page.bindingContext = createViewModel();
};
