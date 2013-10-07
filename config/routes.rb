TinyMCE::Rails::Engine.routes.draw do

  resources :uploads, except: [:new, :edit] do
    collection do 
      post :folder
      delete "folder/:id", action: :destroy_folder, as: :destroy_folder
      put "folder/:id", action: :update_folder, as: :update_folder
    end
    member do
      put 'drop(/:folder_id)', action: :drop, as: :drop
    end 
  end
end