require 'rails_helper'

describe Vote do
  context 'validations' do
  	it { is_expected.to validate_presence_of :type }
  end

  context 'assocations' do
  	it { is_expected.to belong_to :user }
  	it { is_expected.to belong_to :joke }
  end
end
