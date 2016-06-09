require 'rails_helper'

describe Joke do
  context 'validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_length_of(:content).is_at_least(20) }
  end

  context 'assocations' do
    it { is_expected.to have_many :votes }
  end

  describe '.take_excluse' do
  	let!(:jokes) { create_list(:joke, 3) }
  	let!(:excluses) { [jokes.first.id, jokes.second.id] }

  	it 'returns a joke has id not in excluses' do
  		expect(Joke.take_excluse(excluses).id.in? excluses).to be false
  	end
  end
end
