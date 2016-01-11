class TwitterResult
  include ActiveModel::Model
  attr_accessor :user_screen_name, :text, :url

  def initialize(tweet)
    @user_screen_name = tweet.user.screen_name
    @text = tweet.text
    @url = tweet.url
  end
end