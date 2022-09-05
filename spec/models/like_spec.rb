require "rails_helper"

RSpec.describe Like,type: :model do

  describe "validates associations" do
    it "with user" do
        relation = described_class.reflect_on_association(:user)
        expect(relation.macro).to eq :belongs_to
      end

      it "with tweet" do
        relation = described_class.reflect_on_association(:tweet)
        expect(relation.macro).to eq :belongs_to
      end
  end
  
end