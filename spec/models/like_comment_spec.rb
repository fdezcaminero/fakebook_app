require 'rails_helper'

RSpec.describe LikeComment, type: :model do
  let(:user) do
    User.create!(username: 'Foobar', email: 'foobar@bar.com',
                 password: 'foobar', password_confirmation: 'foobar')
  end

  let(:post) do
    user.posts.create!(content: 'Test Post')
  end

  let(:comment) do
    post.comments.create!(user: user, content: 'Anything')
  end

  subject do
    comment.like_comments.create!(user: user)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a comment' do
    subject.comment = nil
    expect(subject).to_not be_valid
  end
end
