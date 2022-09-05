require "rails_helper"

RSpec.describe Notification,type: :model do
  describe "validates associations" do
    it "with actor" do
      relation = described_class.reflect_on_association(:actor)
      expect(relation.macro).to eq :belongs_to
    end

    it "with recipient" do
      relation = described_class.reflect_on_association(:recipient)
      expect(relation.macro).to eq :belongs_to
    end


    it "with notifiable" do
      relation = described_class.reflect_on_association(:notifiable)
      expect(relation.macro).to eq :belongs_to
    end
  end
end