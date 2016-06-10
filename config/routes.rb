Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { registrations: 'registrations' }  
  
  resources :jokes do
  	member do
	    post 'like'
	    post 'dislike'
	  end
  end

  root 'home#index'
end
