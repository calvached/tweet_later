get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  puts '==================================================='
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  @screen_name = @access_token.params["screen_name"]
  oauth_token = @access_token.params["oauth_token"]
  oauth_secret = @access_token.params["oauth_token_secret"]

   @user = User.find_or_create_by(username: @screen_name)
   @user.update( oauth_token: oauth_token, oauth_secret: oauth_secret)
   @user.save

  session.delete(:request_token)
  session[:access_token] = @access_token

erb :index
end

post '/send_tweet' do
   User.find_by(username: session[:access_token].params[:screen_name]).tweet(params["tweet_text"])

  # redirect '/'
end

get '/status/:job_id' do
  p params[:job_id]
  # return the status of a job to an AJAX call
  # job_is_complete(params[:job_id])
  "true"
end

post '' do
end
