module WikipediaGateway
  def self.query(query)
    return [] if query.blank?

    begin
      wikis = []
      WIKI_CLIENT.custom_query(list: "search", srsearch: query, srwhat: "text",
                               srlimit: WIKI_SEARCH_LIMIT)[1].each_element do |w|
        wikis << WikipediaResult.new(title: w.attributes['title'],
                                     snippet: w.attributes['snippet'],
                                     size: w.attributes['size'],
                                     wordcount: w.attributes['wordcount'],
                                     timestamp: w.attributes['timestamp'])
      end
    rescue MediaWiki::Exception=>e
      wikis = []
    end

    return wikis
  end
end