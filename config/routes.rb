Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => "homes#top"
    resources :calendar, only: [:new, :index, :edit, :create, :update]
    resources :customers, only: [:show, :index, :edit, :update]
  end

  scope module: :public do
    root to: 'homes#top'

    get 'dates/confirmation' => "date#confirmation"
    get 'dates/completion' => "date#completion"

    resources :date, only: [:show, :index, :new, :create]
    
    resources :offs do
      member do
        get :show_absences    # お休み確認ページ
        get :edit_absence     # お休み変更ページ
        patch :update_absence # お休み更新アクション
        delete :destroy       # 削除アクション
      end
    end

    get '/calender/index' => "calendar#index"

    resources :child, only: [:new, :edit, :update, :create]

    # マイページのルートに名前付きルートを追加
    get '/customers/show' => "customers#show", as: 'customers_show'
    get '/customers/information/edit' => "customers#edit"
    patch '/customers/information' => "customers#update"
    get 'customers/unsubscribe' => "customers#unsubscribe"
    patch 'customers/withdrawal' => "customers#withdrawal"
    get '/about' => "homes#about"

    resources :items, only: [:index, :show]
  end
end
