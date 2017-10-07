document.addEventListener("turbolinks:load", function() {
  

  $('#update').click(function(event){
    // event.preventDefault();  //only for testing
    $(this).removeClass("btn-info").addClass("btn-warning");
    $(this).prop('disabled', true);

    timeoutID = window.setTimeout(resetButton, 2000);
    function resetButton() {
      $(this).removeClass("btn-warning").addClass("btn-info");
      $(this).prop('disabled', false);
    }
  });
  $('#update-logged-out').click(function(event){
    alert('You must be logged in as an admin to update the results :(  ');
  });
  $('#update-logged-out').hover(function(event){
    console.log('Hover detected');
    // Select a specified element
    // $('#myTooltip').tooltip();
    // $('#update-logged-out').tooltip(); 
  });

  $('[data-toggle="tooltip"]').tooltip()

});