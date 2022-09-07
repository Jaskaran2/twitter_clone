require "rails_helper"

RSpec.describe User,type: :model do


  let(:actor){ create(:user) }
  let(:recipient){ create(:user) }

  describe "validates associations" do
    
    it "with tweets" do
      relation = described_class.reflect_on_association(:tweets)
      expect(relation.macro).to eq :has_many
    end

    it "with likes" do
      relation = described_class.reflect_on_association(:likes)
      expect(relation.macro).to eq :has_many
    end

    it "with active_friendships" do
      relation = described_class.reflect_on_association(:active_friendships)
      expect(relation.macro).to eq :has_many
    end

    it "with following" do
      relation = described_class.reflect_on_association(:following)
      expect(relation.macro).to eq :has_many
    end

    it "with passive_friendships" do
      relation = described_class.reflect_on_association(:passive_friendships)
      expect(relation.macro).to eq :has_many
    end

    it "with followers" do
      relation = described_class.reflect_on_association(:followers)
      expect(relation.macro).to eq :has_many
    end

    it "with notifications" do
      relation = described_class.reflect_on_association(:notifications)
      expect(relation.macro).to eq :has_many
    end

  end
   

  describe 'validate email' do
    let(:user_present){create(:user)}

    it 'validates presence' do
        user=User.new
        user.email=""
        user.validate
        expect(user.errors[:email]).to include("can't be blank")
    end

    it "validates format" do
        user=User.new
        user.email="hello"
        user.validate
        expect(user.errors[:email]).to include("is invalid")
    end

    it "validates if email is already present" do

        user = User.new
        user.email = user_present.email
        user.validate
        expect(user.errors[:email]).to include("has already been taken")
    end

  end

  describe "validates passsword" do
    it "validates password length" do 
        user=User.new
        user.password="123"
        user.validate
        expect(user.errors[:password].size).to eq(1)
    end

  end


  describe "check methods in user model" do

    it "checks #like" do
      tweet = create(:tweet,user: recipient)
      # notification = create(:notification,:for_tweet ,recipient: recipient, actor: actor, action: "like") 
      expect{ actor.like(tweet)}.to change{Like.count}.by(1)
    end

    it "checks #unlike" do
      tweet = create(:tweet,user: recipient)
      actor.like(tweet)
      expect{ actor.unlike(tweet)}.to change{Like.count}.by(-1)
    end

    it "check #liked?" do
      tweet = create(:tweet,user: recipient)
      actor.like(tweet)
      expect(actor.liked?(tweet)).to eq(true)
    end

    it "checks #follow" do
      expect{ actor.follow(recipient) }.to change{Notification.count}.by(1)
    end

    it "checks #unfollow" do    
      actor.follow(recipient)
      expect{ actor.unfollow(recipient) }.to change{Notification.count}.by(-1)
    end

    it "check #following?" do
      actor.follow(recipient)
      expect(actor.following?(recipient)).to eq(true)
    end
    
  end 
end