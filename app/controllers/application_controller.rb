require './config/environment'
require 'sinatra/flash'
require 'sinatra/base'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "shhh_its_a_secret"
  end

  get "/" do
    erb :welcome
  end


    helpers do
      def current_user
        BoardMember.find_by_id(session[:user_id])
      end

      def logged_in?
        !!session[:user_id]
      end

      def not_logged_in_and_current_user
        if !logged_in? || current_user != BoardMember.find_by_slug(params[:slug])
          flash[:message] = "You do not have permission"
          redirect '/login'
        end
      end
    end
end
