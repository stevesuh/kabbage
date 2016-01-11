class SearchController < ApplicationController

  def home
  end

  def search
    @tweets = TWITTER_CLIENT.search(params[:q]).take(20).collect { |t| TwitterResult.new(t)}
    @wikis = []
    WIKI_CLIENT.custom_query(list: "search", srsearch: params[:q], srwhat: "text",
                                      srlimit: 50)[1].each_element do |w|
      @wikis << WikipediaResult.new(w.attributes['title'], w.attributes['snippet'],
                          w.attributes['size'], w.attributes['wordcount'],
                          w.attributes['timestamp'])
    end
    return @tweets, @wikis
  end
end
