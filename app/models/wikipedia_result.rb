class WikipediaResult
  include ActiveModel::Model
  attr_accessor :title, :snippet, :size, :wordcount, :timestamp, :url

  def initialize(title, snippet, size, wordcount, timestamp)
    @title = title
    @snippet = snippet
    @size = size
    @wordcount = wordcount
    @timestamp = timestamp
    @url = "https://en.wikipedia.org/wiki/" + @title if @title
  end
end