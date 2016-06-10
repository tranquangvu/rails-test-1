require 'rails_helper'

describe User do
  describe '#read_jokes' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns list read jokes of user' do
      expect(user.read_jokes).to include jokes.first
    end
  end

  describe '#available_jokes' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns list read jokes of user' do
      expect(user.available_jokes).to include jokes.last
    end
  end

  describe '#next_joke' do
    let!(:jokes)    { create_list(:joke, 2) }
    let!(:user)     { create(:user) }

    before do
      create(:vote, user: user, joke: jokes.first)
    end

    it 'returns next joke which user can read' do
      expect(user.next_joke).to eq jokes.last
    end
  end
end
