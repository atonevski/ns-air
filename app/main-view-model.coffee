Observable = require("data/observable").Observable

getMessage = (counter) ->
  if counter <= 0
    "Hoorraaay! You unlocked the NativeScript clicker achievement!"
  else
    "#{ counter } taps left"

exports.createViewModel = () ->
  console.log "Enterred createViewModel"
  viewModel = new Observable()
  viewModel.counter = 55
  viewModel.message = getMessage viewModel.counter

  viewModel.onTap = () ->
    @counter--
    @set 'message', getMessage(@counter)

    # here insert if counter % 20 is 0 then load new view
    if (@counter + 1) % 10 is 0
      application = require 'application'
      Toast = android.widget.Toast
      Toast.makeText application.android.context,
              "This should bring you to view loading JSON data when counter is #{@counter + 1}",
              Toast.LENGTH_LONG
        .show()
      frame = require 'ui/frame'
      frame.topmost().navigate('views/sk-region/sk-region')

  viewModel
