require 'rails_helper'

describe User do
  context 'validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to have_attached_file(:avatar) }
    it { is_expected.to validate_attachment_content_type(:avatar).
                        allowing('image/png', 'image/gif').
                        rejecting('text/plain', 'text/xml') }
  end

  describe '#available_jokes' do
    let!(:first_joke)       { create(:joke) }
    let!(:second_joke)      { create(:joke) }
    let!(:user)             { create(:user) }

    before do
      create(:vote, user: user, joke: first_joke)
    end

    it 'returns list read jokes of user' do
      expect(user.available_jokes).to include second_joke
    end
  end

  describe '#next_joke' do
    let!(:first_joke)       { create(:joke) }
    let!(:second_joke)      { create(:joke) }
    let!(:user)             { create(:user) }

    before do
      create(:vote, user: user, joke: first_joke)
    end

    it 'returns next joke which user can read' do
      expect(user.next_joke).to eq second_joke
    end
  end


  describe '#roles' do
    let!(:user)             { create(:user, roles_mask: 3) }

    it 'returns list roles of user' do
      expect(user.roles).to eq [:admin, :guest]
    end
  end

  describe '#roles=' do
    let!(:user)             { create(:user, roles_mask: nil) }

    before do
      user.roles = 'admin', 'guest'
    end

    it 'sets roles of user' do
      expect(user.roles).to eq [:admin, :guest]
    end
  end

  describe '#has_role?' do
    let!(:user)             { create(:user) }

    it 'reuturn true if user has that role' do
      expect(user.has_role?(:guest)).to be true
      expect(user.has_role?(:admin)).to be false
    end
  end
end
