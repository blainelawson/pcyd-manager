class BoardMemberController < ApplicationController

  get '/signup' do
    erb :'board-members/create_board_member'
  end

  post '/signup' do
    binding.pry
    @user = BoardMember.create(params[:board_member])
  end

  get '/login' do
    erb :'/board-members/login'
  end

  post '/login' do
    @user = BoardMember.find_by(name: params[:name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      binding.pry
      redirect "/board-members/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  get '/board-members/:slug' do
    @user = current_user
    erb :'/board-members/show'
  end

  get '/board-members/:slug/edit' do
    @user = current_user
    erb :'/board-members/edit'
  end

  patch '/board-members/:slug' do
    binding.pry
    user = BoardMember.find_by_slug(params[:slug])
binding.pry
    user.update(params[:board_member])
  end

  helpers do
    def current_user
      BoardMember.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
