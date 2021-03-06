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

  

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user 
      @current_user ||= User.find_by_id(session[:user][:id]) if session[:user][:id]
    end

    def is_auth?(character)
      character.user == current_user
    end
  end

end
