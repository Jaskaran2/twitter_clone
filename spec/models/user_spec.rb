require "rails_helper"

RSpec.describe User,type: :model do

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
    let!(:user_present){create(:user)}

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

  describe "validates passsword length" do
    it "validates password length" do 
        user=User.new
        user.password="123"
        user.validate
        expect(user.errors[:password].size).to eq(1)
    end

end
   
   
end