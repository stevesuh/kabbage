class SearchController < ApplicationController

  def home
  end

  def search
    @results = TWITTER_CLIENT.search(params[:q])
  end
end
