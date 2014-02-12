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
 # oauth = Twitter.OAuth.new()

 # puts params[:oauth_token]
 # puts params[:oauth_verifier]
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  puts '==================================================='
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  @screen_name = @access_token.params["screen_name"]
  oauth_token = @access_token.params["oauth_token"]
  oauth_secret = @access_token.params["oauth_token_secret"]

   @user = User.find_or_create_by(username: @screen_name)
   @user.update( oauth_token: oauth_token, oauth_secret: oauth_secret)
   @user.save

   # p session
   # p session.params[:oauth_token]
   # p session.params[:oauth_token_secret]

   # p "==================================================="
   # p "==================================================="
   # p session['username']
   # p session['username'].first[:oauth_token]
   # p session['username'].first[:oauth_secret]
  session.delete(:request_token)
  session[:access_token] = @access_token

erb :index
end

post '/send_tweet' do

  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = session[:access_token].params["oauth_token"]
    config.access_token_secret = session[:access_token].params["oauth_token_secret"]
  end

  client.update(params[:tweet_text])
  redirect '/'
end

#
