require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end
  
  get '/account' do
    session[:user_id] ? (erb :account) : (erb :error)  
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && params["password"] == @user.password
      session[:user_id] = @user.id
      redirect '/account'
    end
      erb :error
  end

  get '/error' do
    erb :error
  end

end

