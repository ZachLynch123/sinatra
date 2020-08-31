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
        if @character.save
          redirect "users/#{session[:user][:id]}"
        else 
          redirect '/characters/new'
        end
      end

      # Read 

      get '/characters/:id/all' do 
        @characters = Character.where("user_id = ?", params[:id])
        
        erb :'characters/all'
      end

      get '/characters/:id/details' do 
        @character = Character.where("id = ?", params[:id])
        erb :'characters/details'
      end


      # Update
      get '/characters/:id/edit' do
        @character = Character.find(params[:id])
        erb :'characters/edit'
      end


      post '/characters/:id/edit' do 
        redirect :"/characters/#{params[:id]}/edit"
      end

      patch '/characters/:id' do 
        # add logic to make sure that the character belongs to the current user
        
        @character = Character.find(params[:id])
        if @character.user_id == session[:user][:id]
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
      end


      # Delete

      delete '/characters/:id' do 
        # add logic to make sure that the character belongs to the current user
        @character = Character.find_by(:id => params[:id])
        if @character.user_id == session[:user][:id]
          @character.delete
          redirect :"/users/#{session[:user][:id]}"
        end
      end

      # Add A read, make it so you can view all the characters
      # and see all the details for a single character related to the user

      # limit crud functionality for each user 

end
