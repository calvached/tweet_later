
class User < ActiveRecord::Base
  validates :username, :uniqueness => true
  has_many :tweets

  def tweet(status)
    tweet = self.tweets.create!(:status => status)
    puts "========================= Return Job ID ========================"
    p TweetWorker.perform_async(tweet.id) # return a job ID
  end
end
