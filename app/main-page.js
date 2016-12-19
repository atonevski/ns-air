var createViewModel;

createViewModel = require("./main-view-model").createViewModel;

exports.onNavigatingTo = function(args) {
  var page;
  console.log("Enterred Main Page");
  page = args.object;
  return page.bindingContext = createViewModel();
};
