var Observable, getMessage;

Observable = require("data/observable").Observable;

getMessage = function(counter) {
  if (counter <= 0) {
    return "Hoorraaay! You unlocked the NativeScript clicker achievement!";
  } else {
    return counter + " taps left";
  }
};

exports.createViewModel = function() {
  var viewModel;
  console.log("Enterred createViewModel");
  viewModel = new Observable();
  viewModel.counter = 55;
  viewModel.message = getMessage(viewModel.counter);
  viewModel.onTap = function() {
    var Toast, application, frame;
    this.counter--;
    this.set('message', getMessage(this.counter));
    if ((this.counter + 1) % 10 === 0) {
      application = require('application');
      Toast = android.widget.Toast;
      Toast.makeText(application.android.context, "This should bring you to view loading JSON data when counter is " + (this.counter + 1), Toast.LENGTH_LONG).show();
      frame = require('ui/frame');
      return frame.topmost().navigate('views/sk-region/sk-region');
    }
  };
  return viewModel;
};
