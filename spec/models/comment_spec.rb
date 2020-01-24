require 'rails_helper'

RSpec.describe Comment, type: :post do
  let(:user) do
    User.create!(username: 'Foobar', email: 'foobar@bar.com',
                 password: 'foobar', password_confirmation: 'foobar')
  end

  let(:post) do
    user.posts.create!(content: 'Test Post')
  end

  subject do
    post.comments.create!(user: user, content: 'Anything')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'a user can have more than one comment' do
    comment1 = post.comments.create!(user: user, content: 'Anything')
    comment2 = post.comments.create!(user: user, content: 'Whatever')

    expect(post.reload.comments).to eq([comment1, comment2])
  end

  it 'is not valid without a content' do
    subject.content = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid without an user id' do
    subject.user = nil
    expect(subject).to_not be_valid
  end
end
