require 'rails_helper'

describe VoteHandler do
  describe '#joke' do
    let!(:jokes)          { create_list(:joke, 2) }
    let!(:user)           { create(:user) }
    let!(:vote_handler)   { VoteHandler.new(jokes.first, user) }

    it 'returns a joke with provided id' do
      expect(vote_handler.joke).to eq jokes.first
    end
  end

  describe '#like' do
    let!(:joke)           { create(:joke) }
    let!(:user)           { create(:user) }
    let!(:vote_handler)   { VoteHandler.new(joke, user) }

    it 'creates new like to joke by user' do
      expect{ vote_handler.like }.to change{ Vote.count }.from(0).to(1)
      expect(Vote.last.vote_type).to eq 'like'
      expect(Vote.last.joke).to eq joke
      expect(Vote.last.user).to eq user
    end
  end

  describe '#dislike' do
    let!(:joke)           { create(:joke) }
    let!(:user)           { create(:user) }
    let!(:vote_handler)   { VoteHandler.new(joke, user) }

    it 'creates new dislike to joke by user' do
      expect{ vote_handler.dislike }.to change{ Vote.count }.from(0).to(1)
      expect(Vote.last.vote_type).to eq 'dislike'
      expect(Vote.last.joke).to eq joke
      expect(Vote.last.user).to eq user
    end
  end

  describe '#next_joke' do
    let!(:jokes)          { create_list(:joke, 2) }
    let!(:user)           { create(:user) }
    let!(:vote_handler)   { VoteHandler.new(jokes.first, user) }

    context 'when like' do
      before do
        vote_handler.like
      end

      it 'returns next joke which user can read' do
        expect(vote_handler.next_joke).to eq jokes.last
      end
    end

    context 'when dislike' do
      before do
        vote_handler.dislike
      end

      it 'returns next joke which user can read' do
        expect(vote_handler.next_joke).to eq jokes.last
      end
    end
  end
end