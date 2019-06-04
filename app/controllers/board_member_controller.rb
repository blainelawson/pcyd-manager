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
      redirect '/board-members'
    else
      redirect '/login'
    end
  end
end
