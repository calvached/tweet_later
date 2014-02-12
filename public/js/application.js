$(document).ready(function() {
  $("#tweet_form").submit(function(e){
    e.preventDefault();

    var text = $("#tweet").val();
    var tweet = {tweet_text: text};
    beforeLoad();
    // $.ajax({
    //   type: "POST",
    //   url: "/send_tweet",
    //   data: tweet,
    //   success: afterLoad(jobId)

    // });

  $.post('/send_tweet', tweet, afterLoad);

    function afterLoad(jobId){
      console.log(jobId);
      checkStatus(jobId);
      $('#tweet').prop('disabled', false);
      $("#ajax_loader").remove();
      $("<p>Success!</p>").appendTo("#success");

    }
    function beforeLoad(){
      $("#tweet").prop('disabled', true);
      $("<img src='ajax-loader.gif'/>").appendTo("#ajax_loader");
    }

    function checkStatus(jobId) {
      // base case until true
      $.get('/status/' + jobId, function(response) {
        while (response.responseText !== "true") {
          $.get('/status/' + jobId, function(response)
        }

      });
      ////
      // if(response.responseText === "true") {
      //   return 1;
      // } else {
      //   checkStatus(jobId);
      // };
    };


  });
});

// $.get(url, function (data) {

// })

// post call will receive a job id as string +
// send job id to /status/:job_id
// keep resending until job status returned true
// show "Success!" in html view
