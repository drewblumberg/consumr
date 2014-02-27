require 'spec_helper'

describe Medium do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  context "title" do
    it "should be required" do
      medium = FactoryGirl.build(:medium, user: @user, title: "")
      expect(medium.errors_on(:title)).to include("can't be blank")
    end
  end
  context "status" do
    it "should be required" do
      medium = FactoryGirl.build(:medium, user: @user, status: "")
      expect(medium.errors_on(:status)).to include("can't be blank")
    end
  end
  context "category" do
    it "should be required" do
      medium = FactoryGirl.build(:medium, user: @user, category: "")
      expect(medium.errors_on(:category)).to include("can't be blank")
    end
  end
end
