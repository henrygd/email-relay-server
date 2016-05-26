(function() {
  var global = window;
  var ERS = global.ERS = {};
  var button = $('#submit_button');
  var resultHolder = $('#result_holder');
  var form = $('form');
  var formReady = 1;

  // display key response
  ERS.displayResult = function(result) {
    resultHolder.html(result);
  };

  // hide loading icon on button
  $( document )
    .ajaxStart(showLoader)
    .ajaxStop(hideLoader);
  function hideLoader() {
    button.removeClass('loading-button');
  }
  function showLoader() {
    button.addClass('loading-button');
  }

  // prevent multiple form submissions within 1 second
  form.on('submit', function() {
    if (!formReady) {
      return false;
    }
    formReady = 0;
    setTimeout(function() {
      formReady = 1;
    }, 1000);
  });

})();
