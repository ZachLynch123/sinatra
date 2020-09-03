class UsersController < ApplicationController

    



    get '/users/:id' do 
      if logged_in?
          @user = User.find(params[:id])
          @characters = Character.where("user_id = ?", params[:id])
          session[:user] = @user
          @session = session
          erb :'/users/show'
      else
        redirect '/login'
      end
      end









end