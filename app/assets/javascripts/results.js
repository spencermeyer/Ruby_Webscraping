document.addEventListener("turbolinks:load", function() {
  $('#update').click(function(event){
    // event.preventDefault();  //only for testing
    console.log('click action which makes button should be disabled.');
    $(this).removeClass("btn-info").addClass("btn-warning");
    $(this).prop('disabled', true);

    timeoutID = window.setTimeout(resetButton, 2000);
    function resetButton() {
      console.log('should be after 2 seconds');
      $(this).removeClass("btn-warning").addClass("btn-info");
      $(this).prop('disabled', false);
    }
  });
});