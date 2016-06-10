require 'rails_helper'

describe User do
  context 'validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to have_attached_file(:avatar) }
    it { is_expected.to validate_attachment_content_type(:avatar).
                        allowing('image/png', 'image/gif').
                        rejecting('text/plain', 'text/xml') }
  end

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
