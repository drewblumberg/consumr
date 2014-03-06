require 'spec_helper'

describe Friendship do
  context "user_id" do
    it "should be required" do
      friendship = FactoryGirl.build(:friendship, user_id: "")
      expect(friendship.errors_on(:user_id)).to include("can't be blank")
    end
  end

  context "friend_id" do
    it "should be required" do
      friendship = FactoryGirl.build(:friendship, friend_id: "")
      expect(friendship.errors_on(:friend_id)).to include("can't be blank")
    end
  end

  context "are_friends class method" do
    before do
      @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    end
    it "should return false if user and friend are the same user" do
      expect(Friendship.are_friends(@user1, @user1)).to be false
    end
    it "should return true if friendship records are created" do
      @friendship_for_user = FactoryGirl.create(:friendship, user: @user1, friend: @user2, status: "accepted")
      @friendship_for_other_user = FactoryGirl.create(:friendship, user: @user2, friend: @user1, status: "accepted")
      expect(Friendship.are_friends(@user1, @user2)).to be true
      expect(Friendship.are_friends(@user2, @user1)).to be true
    end
    it "should return false if no friendship created" do
      expect(Friendship.are_friends(@user1, @user2)).to be false
      expect(Friendship.are_friends(@user2, @user1)).to be false
    end
  end

  context "request class method" do
    before do
      @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    end
    it "should return false if user and friend are the same user" do
      expect(Friendship.request(@user1, @user1)).to be false
    end
    it "should return false if user and friend are already friends" do
      @friendship_for_user = FactoryGirl.create(:friendship, user: @user1, friend: @user2, status: "accepted")
      @friendship_for_other_user = FactoryGirl.create(:friendship, user: @user2, friend: @user1, status: "accepted")
      expect(Friendship.request(@user1, @user2)).to be false
      expect(Friendship.request(@user2, @user1)).to be false
    end
    it "should return true if friendship records are created" do
      expect(Friendship.request(@user1, @user2)).to be true
    end
    it "should save the records in the database" do
      Friendship.request(@user1, @user2)
      expect(Friendship.find_by(user: @user1, friend: @user2)).not_to be_nil
      expect(Friendship.find_by(user: @user2, friend: @user1)).not_to be_nil
    end
    it "should have a pending status for user 1" do
      Friendship.request(@user1, @user2)
      expect(Friendship.find_by(user: @user1, friend: @user2).status).to eq('pending')
    end
    it "should have a requested status for user 1" do
      Friendship.request(@user1, @user2)
      expect(Friendship.find_by(user: @user2, friend: @user1).status).to eq('requested')
    end
  end

  context "accept class method" do
    before do
      @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    end
    it "should return false if either friendship record is nil" do
      expect(Friendship.accept(@user1, @user2)).to be false
      expect(Friendship.accept(@user2, @user1)).to be false
    end
    it "should return true for a successful acceptance" do
      Friendship.request(@user1, @user2)
      expect(Friendship.accept(@user1, @user2)).to be true
    end
    it "should update the status of each friendship record to accepted" do
      Friendship.request(@user1, @user2)
      Friendship.accept(@user1, @user2)
      expect(Friendship.find_by(user: @user1, friend: @user2).status).to eq('accepted')
      expect(Friendship.find_by(user: @user2, friend: @user1).status).to eq('accepted')
    end
  end

  context "reject class method" do
    before do
      @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    end
    it "should return false if either friendship record is nil" do
      expect(Friendship.reject(@user1, @user2)).to be false
      expect(Friendship.reject(@user2, @user1)).to be false
    end
    it "should return true for a successful rejection" do
      Friendship.request(@user1, @user2)
      expect(Friendship.reject(@user1, @user2)).to be true
    end
    it "should remove each friendship record" do
      Friendship.request(@user1, @user2)
      Friendship.reject(@user1, @user2)
      expect(Friendship.find_by(user: @user1, friend: @user2)).to be_nil
      expect(Friendship.find_by(user: @user2, friend: @user1)).to be_nil
    end
  end
end