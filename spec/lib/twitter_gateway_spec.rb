require 'rails_helper'

describe TwitterGateway do
  describe '.query' do
    it "returns a list of Twitter results" do
      results = TwitterGateway.query('bieber')
      expect(results).not_to be_empty
      for result in results do
        expect(result).to be_instance_of(TwitterResult)
      end
    end

    it "returns an empty array if given a blank query" do
      expect(TwitterGateway.query('')).to be_blank
    end

    it "returns an empty array if a Twitter exception is raised" do
      dbl = double(Twitter::REST::Client)
      stub_const("TWITTER_CLIENT", dbl)
      allow(dbl).to receive(:search).and_raise(Twitter::Error::ServiceUnavailable)
      expect(TwitterGateway.query('bieber')).to eq([])
    end

  end
end