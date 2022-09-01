require "rails_helper"

RSpec.describe Tweet,type: :model do
  describe "validates associations" do   

    it "with user" do
      relation = described_class.reflect_on_association(:user)
      expect(relation.macro).to eq :belongs_to
    end
   
    it "with likes" do
      relation = described_class.reflect_on_association(:likes)
      expect(relation.macro).to eq :has_many
    end

    it "with retweets" do
      relation = described_class.reflect_on_association(:child_tweets)
      expect(relation.macro).to eq :has_many
    end
    # it { is_expected.to have_one_attached(:tweet_image) }
  end
  
 

end