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

    # before do
    #     initial_friendship_count = Friendship.count
    #     user1.follow(user2)
    # end


    it "send_follow_notification" do
        initial_friendship_count = Friendship.count
        user1.follow(user2)
        expect(Friendship.count).to eq( initial_friendship_count+1 )
    end

    it "delete_follow_notification" do
        initial_friendship_count = Friendship.count
        user1.follow(user2)
        user1.unfollow(user2)
        expect(Friendship.count).to eq( initial_friendship_count )
    end

  end
  
end