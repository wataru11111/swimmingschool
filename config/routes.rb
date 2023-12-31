Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get '/' => "homes#top"
    resources :calendar, only: [:new, :index, :edit, :create, :update]
    resources :customers, only: [:show, :index, :edit,:update]

  end

  scope module: :public do
    root to: 'homes#top'

    get 'dates/confirmation' => "date#confirmation"
    get 'dates/completion' => "date#completion"

    resources :date, only: [:show, :index, :new, :create]
    resources :offs, only: [:update, :create, :index, :new]


    get '/calender/index' => "calendar#index"

    resources :child, only: [:new,:edit,:update, :create]

    get '/customers/show' => "customers#show"
    get '/customers/information/edit' => "customers#edit"
    patch '/customers/information' => "customers#update"
    get 'customers/unsubscribe' => "customers#unsubscribe"
    patch 'customers/withdrawal' => "customers#withdrawal"
    get '/about' => "homes#about"

    resources :items, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end