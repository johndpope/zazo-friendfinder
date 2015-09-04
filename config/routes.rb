Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :connections, only: [:create]
      resources :suggestions, only: [:index]
    end
  end

  get 'status', to: Proc.new { [200, {}, ['']] }
end
