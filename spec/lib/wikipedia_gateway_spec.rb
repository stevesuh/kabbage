require 'rails_helper'

describe WikipediaGateway do
  describe '.query' do
    it "returns a list of Wikipedia results" do
      results = WikipediaGateway.query('bieber')
      expect(results).not_to be_empty
      for result in results do
        expect(result).to be_instance_of(WikipediaResult)
      end
    end
    
    it "returns an empty array if given a blank query" do
      expect(WikipediaGateway.query('')).to be_blank
    end

    it "returns an empty array if a MediaWiki exception is raised" do
      dbl = double(MediaWiki::Gateway)
      stub_const("WIKI_CLIENT", dbl)
      allow(dbl).to receive(:custom_query).and_raise(MediaWiki::Exception)
      expect(WikipediaGateway.query('bieber')).to eq([])
    end

  end
end