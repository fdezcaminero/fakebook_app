# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :post do
  let(:user) do
    User.create!(username: 'Foobar', email: 'foobar@bar.com',
                 password: 'foobar', password_confirmation: 'foobar')
  end

  subject do
    user.posts.create!(content: 'Anything')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'a user can have more than one post' do
    post1 = user.posts.create!(content: 'Anything')
    post2 = user.posts.create!(content: 'Whatever')

    expect(user.reload.posts).to eq([post1, post2])
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
