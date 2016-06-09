require 'rails_helper'

describe JokesController do
  describe '#index' do
    def do_request
      get :index
    end

    let!(:acc)      { create(:user) }
    let!(:jokes)    { create_list(:joke, 3) }

    before          { sign_in acc } 

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

    let!(:user)     { create(:user) }

    before          { sign_in user }

    it 'renders the :new views' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    def do_request
      post :create, joke: attributes_for(:joke)
    end

    let!(:user)      { create(:user) }

    before           { sign_in user }

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

    let!(:user)     { create(:user) }
    let!(:joke)     { create(:joke) }

    before { sign_in user }

    it 'renders view :edit' do
      do_request
      expect(response).to render_template :edit
    end
  end  

  describe '#update' do
    def do_request
      patch :update, { id: joke.id, joke: { content: new_content } }
    end

    let!(:user)               { create(:user) }
    let!(:new_content)        { 'The joke update content' }
    let!(:joke)               { create(:joke) }

    before                    { sign_in user }

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
    let!(:user)               { create(:user) }

    before                    { sign_in user }

    it 'deletes the product' do
      expect{ do_request }.to change{ Joke.count }.from(1).to(0)
      expect(flash[:notice]).to eq('Joke was successfully destroyed.')
      expect(response).to redirect_to jokes_path
    end
  end

  describe '#like' do
    
  end

  describe '#dislike' do

  end
end 
