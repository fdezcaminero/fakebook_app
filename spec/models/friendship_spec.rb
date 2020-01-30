require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) do
    User.create(username: 'Foo Bar', email: 'foobar@foo.bar',
                password: 'foobar', password_confirmation: 'foobar')
  end

  let(:user2) do
    User.create(username: 'Bar Foo', email: 'barfoo@foo.bar',
                password: 'foobar', password_confirmation: 'foobar')
  end

  subject do
    user1.following_friends.new(requestee: user2)
  end

  it 'must have valid users' do
    expect(subject).to be_valid
  end

  it 'must have a valid requester' do
    subject.requester = nil
    expect(subject).to_not be_valid
  end

  it 'must have a valid requestee' do
    subject.requestee = nil
    expect(subject).to_not be_valid
  end

  it 'disallow self friendship' do
    same_user = Friendship.create(requestee: user1, requester: user1)
    expect(same_user).to_not be_valid
  end
end
