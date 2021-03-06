class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:code_postal, :notel, :avatar])
     devise_parameter_sanitizer.permit(:account_update, keys: [:code_postal, :notel, :avatar])
   end

   # Nécessaire pour la gestion des url des images
   # HOST doit être définie en production
   # heroku config:set HOST=www.my_product.com pour configurer Heroku
   # heroku config:get HOST pour vérifier si c'est OK
   def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
   end

end
