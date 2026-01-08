# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  context 'when valid factory' do
    it { expect(build(:user)).to be_valid }
  end

  describe 'default values' do
    it 'sets nickname not to nil by default' do
      expect(user.nickname).not_to be_empty
    end

    it 'sets email not to nil by default' do
      expect(user.email).not_to be_empty
    end

    it 'sets password not to nil by default' do
      expect(user.password).not_to be_empty
    end
  end

  describe 'validations' do
    describe 'presence validations' do
      it { expect(user).to validate_presence_of :nickname }
      it { expect(user).to validate_presence_of :email }
      it { expect(user).to validate_presence_of :password }
    end

    describe 'uniqueness validations' do
      it { expect(user).to validate_uniqueness_of(:nickname).case_insensitive }
      it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    end

    describe 'format validations' do
      it { expect(user.nickname).to match(/\A[\w.-_]+\z/) }
      it { expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i) }
      it { expect(user.password).to match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/x) }
    end

    describe 'length validations' do
      it { is_expected.to validate_length_of(:nickname).is_at_least(3).is_at_most(30) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(128) }
    end

    describe 'avatar validations' do
      it { is_expected.to validate_content_type_of(:avatar).allowing('image/png', 'image/jpeg', 'image/gif') }
      it { is_expected.to validate_size_of(:avatar).less_than(10.megabytes) }
    end
  end
end
