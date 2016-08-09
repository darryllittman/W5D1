require 'rails_helper'

RSpec.describe User do

  subject(:user) do
    create(:user,
      username: "mister_corgi",
      password: "password")
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:session_token) }

  it {should have_many(:goals) }

  it "sets a pw digest when given a password" do
    expect(user.password_digest).to_not be_nil
    expect(user.password_digest).to_not eq(:password)
  end

  describe "User::find_by_credentials" do
    #before { user.save! }
    before { user }
    it "finds a user, given un and pw" do
      expect(User.find_by_credentials("mister_corgi", "password")).to eq(user)
    end
    it "returns nil when no match" do
      expect(User.find_by_credentials("mister_corgi", "asbdasfasf")).to be_nil
    end
  end



end
