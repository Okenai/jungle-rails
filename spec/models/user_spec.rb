require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.d@gmail.com",
      password: "johndoe",
      password_confirmation: "johndoe"
      )
    end

    it "saves a user when all values are present" do
      expect(@user.save).to eq true
    end
    
    it "fails to save if password does not match the password_confirmation" do
      @user.password_confirmation ="123"
      expect(@user.save).to eq false
    end
    
    it "fails to save when an email is not unique" do
      @user2 = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john.d@gmail.com",
        password: "johndoe",
        password_confirmation: "johndoe"
        )
        @user.save
        expect(@user2.save).to eq false
    end
    
    it "fails to save when an email is not unique and not case sensitive" do
      @user2 = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "JOHN.d@gmail.com",
        password: "johndoe",
        password_confirmation: "johndoe"
      )
      @user.save
      expect(@user2.save).to eq false
    end

    it "fails to save when email is blank" do
      @user.email = ""
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "fails to save when first name is blank" do
      @user.first_name = ""
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "fails to save when last name is blank" do
      @user.last_name = ""
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "fails to save when password is less then 7 chars" do
      @user.password = "123"
      @user.password_confirmation = "123"
      expect(@user.save).to eq false
    end
    
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "eXample@domain.COM",
      password: "johndoe",
      password_confirmation: "johndoe"
      )
    end

    before(:each) do
    @user.save
    end

    it "authenticates registered users" do
    expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq @user
    end
    
    it "authenticates registered users with whitespace" do
      user = User.authenticate_with_credentials("  EXAMPLe@DOMAIN.CoM", @user.password)
      expect(user).to eq @user
    end

    it "authenticates registered users with email case insensitivity" do
      expect(User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", @user.password)).to eq @user
    end

  end

end
