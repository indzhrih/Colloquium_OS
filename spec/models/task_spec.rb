# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) { build(:task) }

  context 'when valid factory' do
    it { expect(build(:task)).to be_valid }
  end

  describe 'default values' do
    it 'sets title not to nil by default' do
      expect(task.title).not_to be_nil
    end

    it 'sets description not to nil by default' do
      expect(task.description).not_to be_nil
    end

    it 'sets status not to nil by default' do
      expect(task.status).not_to be_nil
    end
  end

  describe 'validations' do
    describe 'presence validations' do
      it { expect(task).to validate_presence_of :title }
      it { expect(task).to validate_presence_of :status }
    end

    describe 'length validations' do
      it { expect(task).to validate_length_of(:title).is_at_least(3).is_at_most(30) }
    end

    describe 'inclusion validations' do
      subject(:task) { described_class.new }

      it 'defines status enum' do
        expect(task).to define_enum_for(:status)
          .with_values(todo: 0, in_progress: 1, done: 2)
          .backed_by_column_of_type(:integer)
      end
    end
  end
end
