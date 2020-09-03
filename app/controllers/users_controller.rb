class UsersController < ApplicationController

    
  get "/sign_up" do 
    erb :sign_up
  end

  post "/sign_up" do 
    @user_exists = User.find_by(:username => params[:username])
    if @user_exists || params[:username] == ""
      redirect '/sign_up'
    else
    @user = User.create(:username => params[:username], :password => params[:password])
    @session = session
    
    if @user.save 
      redirect '/login'
    else
      "Invalid username or password"
      redirect '/sign_up'
    end
  end

  end


  get "/login" do 
    erb :login 
  end

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user
      session["user"] = @user
      session["user_id"] = @user.id
      @session = session
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get "/logout" do
    session.clear 
    redirect "/"
  end



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