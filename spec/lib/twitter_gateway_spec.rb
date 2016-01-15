require 'rails_helper'

describe TwitterGateway do
  describe '.query' do
    it "returns an empty array if given a blank query" do
      expect(TwitterGateway.query('')).to be_blank
    end

    it "returns an empty array if a Twitter exception is raised" do
      dbl = double(Twitter::REST::Client)
      stub_const("TWITTER_CLIENT", dbl)
      allow(dbl).to receive(:search).and_raise(Twitter::Error::ServiceUnavailable)
      expect(TwitterGateway.query('bieber')).to eq([])
    end

    it "returns a list of results" do
      expect(TwitterGateway.query('bieber')).not_to be_empty
    end
  end
end