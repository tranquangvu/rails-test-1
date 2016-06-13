require 'rails_helper'

describe VoteHandler do
  describe '#like' do
    let!(:joke)               { create(:joke) }
    let!(:user)               { create(:user) }
    let!(:vote_handler)       { VoteHandler.new(joke, user) }

    it 'creates new like to joke by user' do
      expect{ vote_handler.like }.to change{ Vote.count }.from(0).to(1)
      expect(Vote.last.vote_type).to eq 'like'
      expect(Vote.last.joke).to eq joke
      expect(Vote.last.user).to eq user
    end
  end

  describe '#dislike' do
    let!(:joke)               { create(:joke) }
    let!(:user)               { create(:user) }
    let!(:vote_handler)       { VoteHandler.new(joke, user) }

    it 'creates new dislike to joke by user' do
      expect{ vote_handler.dislike }.to change{ Vote.count }.from(0).to(1)
      expect(Vote.last.vote_type).to eq 'dislike'
      expect(Vote.last.joke).to eq joke
      expect(Vote.last.user).to eq user
    end
  end

  describe '#next_joke' do
    let!(:first_joke)         { create(:joke) }
    let!(:second_joke)        { create(:joke) }
    let!(:user)               { create(:user) }
    let!(:vote_handler)       { VoteHandler.new(first_joke, user) }

    context 'when like' do
      before do
        vote_handler.like
      end

      it 'returns next joke which user can read' do
        expect(vote_handler.next_joke).to eq second_joke
      end
    end

    context 'when dislike' do
      before do
        vote_handler.dislike
      end

      it 'returns next joke which user can read' do
        expect(vote_handler.next_joke).to eq second_joke
      end
    end
  end
end