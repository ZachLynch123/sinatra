class UsersController < Sinatra::Base 

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret_session"
      end



    get '/users/:id' do 
        @user = User.find(params[:id])
        session[:user] = @user
        @session = session
        erb :'/users/show'
      end

    post '/characters' do       
      redirect '/characters/new'
    end

    #TODO: Create list of characters, with buttons to edit and delete
    






end