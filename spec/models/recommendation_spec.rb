require 'spec_helper'

describe Recommendation do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, email: "drew@example.com")
  end
  context "user" do
    it "should be required" do
      rec = FactoryGirl.build(:recommendation, user: User.new, creator_id: @user2.id)
      expect(rec.errors_on(:user)).to be_empty
    end
  end
  context "creator" do
    it "should be required" do
      rec = FactoryGirl.build(:recommendation, user: @user, creator_id: "")
      expect(rec.errors_on(:creator_id)).to include("can't be blank")
    end
  end
  context "body" do
    it "should be required" do
      rec = FactoryGirl.build(:recommendation, user: @user, creator_id: @user2.id, body: "")
      expect(rec.errors_on(:body)).to include("can't be blank")
    end
  end
end