require 'rails_helper'

describe Joke do
  context 'validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_length_of(:content).is_at_least(20) }
  end

  context 'assocations' do
    it { is_expected.to have_many :votes }
  end

  describe '.read_jokes' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns list read jokes of user' do
      expect(Joke.read_jokes(user.id)).to include jokes.first
    end
  end

  describe '.read_joke_ids' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns list read joke\'s ids of user' do
      expect(Joke.read_joke_ids(user.id)).to include jokes.first.id
    end
  end

  describe '.next_joke' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns next joke which user can read' do
      expect(Joke.next_joke(user.id)).to eq jokes.last
    end
  end
end
