require 'rails_helper'

describe WikipediaGateway do
  describe '.query' do
    it "returns an empty array if given a blank query" do
      expect(WikipediaGateway.query('')).to be_blank
    end

    it "returns an empty array if a MediaWiki exception is raised" do
      dbl = double(MediaWiki::Gateway)
      stub_const("WIKI_CLIENT", dbl)
      allow(dbl).to receive(:custom_query).and_raise(MediaWiki::Exception)
      expect(WikipediaGateway.query('bieber')).to eq([])
    end

    it "returns a list of results" do
      expect(WikipediaGateway.query('bieber')).not_to be_empty
    end

  end
end