module TwitterGateway

  def self.query(query)
    return [] if query.blank?

    begin
      tweets = TWITTER_CLIENT.search(query).take(TWITTER_SEARCH_LIMIT).collect { |t| TwitterResult.from_tweet(t)}
    rescue Twitter::Error::ServiceUnavailable => e
      tweets = []
    end

    return tweets
  end

end