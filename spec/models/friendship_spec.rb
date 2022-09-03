require "rails_helper"

RSpec.describe Friendship,type: :model do
  describe "validates associations" do
    it "with follower" do
        relation = described_class.reflect_on_association(:follower)
        expect(relation.macro).to eq :belongs_to
      end

      it "with followed" do
        relation = described_class.reflect_on_association(:followed)
        expect(relation.macro).to eq :belongs_to
      end
  end

  describe "test callback" do

    let(:user1){create(:user)}
    let(:user2){create(:user)}

    it "send_follow_notification" do
        expect{ user1.follow(user2) }.to change{ Friendship.count }.by(1)
    end

    it "delete_follow_notification" do
        user1.follow(user2)
        expect{ user1.unfollow(user2) }.to change{ Friendship.count }.by(-1)
    end

  end
  
end