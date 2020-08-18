require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secret_session"
  end

  get "/" do
    erb :index
  end

  get "/sign_up" do 
    erb :sign_up
  end

  post "/sign_up" do 
    @user = User.create(:username => params[:username], :password => params[:password])
    @session = session
    binding.pry
    if @user.save 
      redirect '/login'
    else
      "Invalid username or password"
      redirect '/sign_up'
    end

  end


  get "/login" do 
    erb :login 
  end

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end


  get '/users/:id' do 
    @user = User.find(params[:id])
    
    erb :'/users/show'
  end


end
