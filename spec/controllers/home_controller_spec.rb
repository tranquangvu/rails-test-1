require 'rails_helper'

describe HomeController do
  describe '#index' do
    def do_request
      get :index
    end

    let!(:user)   { create(:user) }
    let!(:jokes)  { create_list(:joke, 3) }

    before { sign_in user } 

    context 'have not read any jokes before' do
      it 'returns a joke and renders the :index view' do
        do_request
        expect(assigns(:joke)).to eq jokes.first
        expect(response).to render_template :index
      end
    end

    context 'have read jokes before' do
      before do
        @request.session[:read_jokes] = [jokes.first.id, jokes.second.id]
      end

      it 'returns a joke which has not read before and render the :index view' do
        do_request
        expect(assigns(:joke)).to eq jokes.last
        expect(response).to render_template :index
      end
    end
  end
end 
