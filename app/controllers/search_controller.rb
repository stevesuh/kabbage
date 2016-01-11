class SearchController < ApplicationController

  def home
  end

  def search
    begin
      @tweets = TWITTER_CLIENT.search(params[:q]).take(TWITTER_SEARCH_LIMIT).collect { |t| TwitterResult.new(t)}
    rescue Twitter::Error::ServiceUnavailable => e
      @tweets = []
    end

    begin
      @wikis = []
      WIKI_CLIENT.custom_query(list: "search", srsearch: params[:q], srwhat: "text",
                                        srlimit: WIKI_SEARCH_LIMIT)[1].each_element do |w|
        @wikis << WikipediaResult.new(w.attributes['title'], w.attributes['snippet'],
                            w.attributes['size'], w.attributes['wordcount'],
                            w.attributes['timestamp'])
      end
    rescue MediaWiki::Exception=>e
      @wikis = []
    end

    return @tweets, @wikis
  end
end
