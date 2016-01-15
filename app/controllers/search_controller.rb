class SearchController < ApplicationController

  def home
  end

  def search
    @tweets = TwitterGateway.query(params[:q])
    @wikis = WikipediaGateway.query(params[:q])

    redirect_to search_home_path if params[:q].empty?
  end

end
