require './config/environment'

class CharacterController < ApplicationController 


      # Read
      get '/characters' do 
        @characters = current_user.characters
        erb :'characters/all'
      end

      get '/characters/:id/details' do 
        @character = Character.where("id = ?", params[:id])
        erb :'characters/details'
      end

      # Create
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
        if @character.save
          redirect "users/#{session[:user][:id]}"
        else 
          redirect '/characters/new'
        end
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
        @character = Character.find(params[:id])
        if @character.user == current_user
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
        @character = Character.find_by(:id => params[:id])
        if is_auth?(@character)
          @character.delete
          redirect :"/users/#{session[:user][:id]}"
        end
      end

end
