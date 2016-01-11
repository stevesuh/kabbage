class SearchController < ApplicationController

  def home
  end

  def search
    @tweets = TWITTER_CLIENT.search(params[:q]).take(20).collect { |t| TwitterResult.new(t)}
    return @tweets
  end
end
