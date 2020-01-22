# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.create(username: 'Foo Bar', email: 'foobar@foo.bar',
                password: 'foobar', password_confirmation: 'foobar')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.username = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid without an email' do
    subject.email = ''
    expect(subject).to_not be_valid
  end

  it 'must be a valid email' do
    subject.email = 'foobar@foo,bar'
    expect(subject).to_not be_valid
  end

  it 'must contain a password' do
    subject.password = ''
    subject.password_confirmation = ''
    expect(subject).to_not be_valid
  end
end
