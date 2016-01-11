class WikipediaResult
  include ActiveModel::Model
  attr_accessor :title, :snippet, :size, :wordcount, :timestamp

  def initialize(title, snippet, size, wordcount, timestamp)
    @title = title
    @snippet = snippet
    @size = size
    @wordcount = wordcount
    @timestamp = timestamp
  end
end