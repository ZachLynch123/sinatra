require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/sign_in" do
    erb :sign_in
  end

  get "/sign_up" do 
    erb :sign_up
  end

  post "/sign_up" do 
    user = User.new(:username => params[:username], :password => params[:password])

    if user.save 
      redirect '/login'
    else
      "Invalid username or password"
      redirect '/sign_up'
    end

  end


  get "/login" do 
    erb :login 
  end

end
