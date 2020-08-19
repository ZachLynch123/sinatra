require './config/environment'

class CharacterController < Sinatra::Base 

    configure do
        set :public_folder, 'public'
        set :views, 'app/views/'
        enable :sessions 
        set :session_secret, "secret_session"
      end

      get '/characters/new' do 
        erb :'characters/new'
      end


      post '/characters/new' do 

        @character = Character.create(
          :name => params[:name],
          :character_class => params[:class],
          :race => params[:race],
          :strength => params[:strength],
          :dexterity => params[:dexterity],
          :constitution => params[:constitution],
          :intelligence => params[:intelligence],
          :wisdom => params[:wisdom],
          :charisma => params[:charisma]
        )
        @character.user_id = session[:user][:id]
        @character.save

        redirect "users/#{session[:user][:id]}"
      end


end
