class WikipediaResult
  include ActiveModel::Model
  attr_accessor :title, :snippet, :size, :wordcount, :timestamp

  def url
    "https://en.wikipedia.org/wiki/" + @title if @title
  end
end