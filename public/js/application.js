$(document).ready(function() {
  $("#tweet_form").submit(function(e){
    e.preventDefault();

    var text = $("#tweet").val();
    var tweet = {tweet_text: text};
    beforeLoad();
    $.ajax({
      type: "POST",
      url: "/send_tweet",
      data: tweet,
      success: afterLoad()
    });
    function afterLoad(){
      $('#tweet').prop('disabled', false);
      $("#ajax_loader").remove();
      $("<p>Success!</p>").appendTo("#success");
    }
    function beforeLoad(){
      $("#tweet").prop('disabled', true);
      $("<img src='ajax-loader.gif'/>").appendTo("#ajax_loader");
    }
  });
});
