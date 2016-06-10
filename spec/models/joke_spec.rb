require 'rails_helper'

describe Joke do
  context 'validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_length_of(:content).is_at_least(20) }
  end

  context 'assocations' do
    it { is_expected.to have_many :votes }
  end
end
