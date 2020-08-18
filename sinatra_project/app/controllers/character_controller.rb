require './config/environment'

class CharacterController < Sinatra::Base 

    configure do
        set :public_folder, 'public'
        set :views, 'app/views/characters'
        enable :sessions 
        set :session_secret, "secret_session"
      end




end
