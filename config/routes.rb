Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :cages
      resources :dinos
    end
  end
end
