require 'rails_helper'

RSpec.describe User, type: :model do
  describe "name" do
    it "name is valid" do
      @user = User.new(name: "user1", email:"aaa@aaa.aa", password:"password")
      @user.valid?
      expect(@user).to be_valid   
    end
    it "name is invalid" do
      @user = User.new(name: "user1", email: "", password:"password")
      @user.valid?
      expect(@user).not_to be_valid   
    end
  end
  
end
