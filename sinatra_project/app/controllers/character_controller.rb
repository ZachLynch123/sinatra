require './config/environment'

class CharacterController < Sinatra::Base 

    configure do
        set :public_folder, 'public'
        set :views, 'app/views/'
        enable :sessions 
        set :session_secret, "secret_session"
      end

      post '/characters/' do       
        redirect '/characters/new'
      end

      get '/characters/new' do 
        erb :'characters/new'
      end

      # Create
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

      # Update
      get '/characters/:id/edit' do
        @character = Character.find(params[:id])
        erb :'characters/edit'
      end


      post '/characters/:id/edit' do 
        redirect :"/characters/#{params[:id]}/edit"
      end

      post '/characters/:id' do 
        
        @character = Character.find(params[:id])
        @character.update(
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
          redirect :"/users/#{session[:user][:id]}"
      end


      # Delete

      delete '/characters/:id' do 
        @character = Character.find(params[:id])
        @character.delete 
        redirect :"/users/#{session[:user][:id]}"

      end


end
