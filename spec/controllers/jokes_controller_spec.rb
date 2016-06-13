require 'rails_helper'

describe JokesController do
  describe '#index' do
    def do_request
      get :index
    end

    let!(:admin)      { create(:admin) }

    before do
      create_list(:joke, 3)
      sign_in admin
    end

    it 'assigns jokes and return :index views' do
      do_request
      expect(assigns(:jokes).size).to eq 3
      expect(response).to render_template :index
    end
  end

  describe '#new' do
    def do_request
      get :new
    end

    let!(:admin)     { create(:admin) }

    before           { sign_in admin }

    it 'renders the :new views' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    def do_request
      post :create, joke: attributes_for(:joke)
    end

    let!(:admin)      { create(:admin) }

    before            { sign_in admin }

    it 'creates a joke' do
      expect{ do_request }.to change{ Joke.count }.from(0).to(1)
      expect(flash[:notice]).to eq 'Joke was successfully created.'
      expect(response).to redirect_to assigns(:joke)
    end
  end

  describe 'edit' do
    def do_request
      get :edit, id: joke.id
    end

    let!(:admin)     { create(:admin) }
    let!(:joke)     { create(:joke) }

    before { sign_in admin }

    it 'renders view :edit' do
      do_request
      expect(response).to render_template :edit
    end
  end  

  describe '#update' do
    def do_request
      patch :update, { id: joke.id, joke: { content: new_content } }
    end

    let!(:admin)              { create(:admin) }
    let!(:joke)               { create(:joke) }
    let!(:new_content)        { 'The joke update content' }

    before                    { sign_in admin }

    it 'updates the joke' do
      do_request
      expect(joke.reload.content).to eq new_content
      expect(flash[:notice]).to eq 'Joke was successfully updated.'
      expect(response).to redirect_to assigns(:joke)
    end
  end

  describe '#destroy' do
    def do_request
      delete :destroy, id: joke.id
    end

    let!(:joke)               { create(:joke) }
    let!(:admin)               { create(:admin) }

    before                    { sign_in admin }

    it 'deletes the product' do
      expect{ do_request }.to change{ Joke.count }.from(1).to(0)
      expect(flash[:notice]).to eq('Joke was successfully destroyed.')
      expect(response).to redirect_to jokes_path
    end
  end

  describe '#like' do
    def do_request(id)
      post :like, id: id, format: :js
    end

    let!(:first_joke)        { create(:joke) }
    let!(:second_joke)        { create(:joke) }
    let!(:user)               { create(:user) }

    before do
      sign_in user
    end

    context 'current is not the final joke' do
      it 'likes the joke and returns new joke' do
        expect{ do_request(first_joke.id) }.to change{ Vote.count }.from(0).to(1)
        expect(assigns(:res).vote_type).to eq 'like'
        expect(assigns(:next_joke)).to eq second_joke
      end
    end

    context 'current is the final joke' do
      before do
        create(:vote, user: user, joke: first_joke)
      end

      it 'likes the joke and returns no joke' do
        expect{ do_request(second_joke.id) }.to change{ Vote.count }.from(1).to(2)
        expect(assigns(:res).vote_type).to eq 'like'
        expect(assigns(:next_joke)).to be_nil
      end
    end
  end

  describe '#dislike' do
    def do_request(id)
      post :dislike, id: id, format: :js
    end

    let!(:first_joke)         { create(:joke) }
    let!(:second_joke)        { create(:joke) }
    let!(:user)               { create(:user) }

    before do
      sign_in user
    end

    context 'current is not the final joke' do
      it 'likes the joke and returns new joke' do
        expect{ do_request(first_joke.id) }.to change{ Vote.count }.from(0).to(1)
        expect(assigns(:res).vote_type).to eq 'dislike'
        expect(assigns(:next_joke)).to eq second_joke
      end
    end

    context 'current is the final joke' do
      before do
        create(:vote, user: user, joke: first_joke)
      end

      it 'likes the joke and returns no joke' do
        expect{ do_request(second_joke.id) }.to change{ Vote.count }.from(1).to(2)
        expect(assigns(:res).vote_type).to eq 'dislike'
        expect(assigns(:next_joke)).to be_nil
      end
    end
  end
end
