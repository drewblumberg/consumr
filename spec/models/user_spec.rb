require 'spec_helper'

describe User do
  context "first name" do
    it "should be required" do
      user = FactoryGirl.build(:user, first_name: "")
      expect(user.errors_on(:first_name)).to include("can't be blank")
    end
  end
  context "last name" do
    it "should be required" do
      user = FactoryGirl.build(:user, last_name: "")
      expect(user.errors_on(:last_name)).to include("can't be blank")
    end
  end
  context "full name" do
    it "should display space separated name" do
      user = FactoryGirl.create(:user)
      expect(user.full_name).to eq("Jon Snow")
    end
  end
end 
