class UsersController < Sinatra::Base 

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions 
        set :session_secret, "secret_session"
      end



    get '/users/:id' do 
        @user = User.find(params[:id])
        
        erb :'/users/show'
      end



end