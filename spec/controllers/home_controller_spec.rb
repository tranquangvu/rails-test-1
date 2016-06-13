require 'rails_helper'

describe HomeController do
  describe '#index' do
    def do_request
      get :index
    end

    let!(:user)             { create(:user) }
    let!(:first_joke)       { create(:joke) }
    let!(:second_joke)      { create(:joke) }

    before                  { sign_in user } 

    context 'have not read any jokes before' do
      it 'returns a joke and renders the :index view' do
        do_request
        expect(assigns(:joke)).to eq first_joke
        expect(response).to render_template :index
      end
    end

    context 'have read some jokes before' do
      before do
        create(:vote, user: user, joke: first_joke)
      end

      it 'returns a joke which has not read before and render the :index view' do
        do_request
        expect(assigns(:joke)).to eq second_joke
        expect(response).to render_template :index
      end
    end

    context 'have read all jokes before' do
      before do
        create(:vote, user: user, joke: first_joke)
        create(:vote, user: user, joke: second_joke)
      end

      it 'returns no joke and render the :index view' do
        do_request
        expect(assigns(:joke)).to be_nil
        expect(response).to render_template :index
      end
    end
  end
end 
