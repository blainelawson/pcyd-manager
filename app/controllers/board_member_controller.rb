class BoardMemberController < ApplicationController

  get '/signup' do
    erb :'board-members/create_board_member'
  end

  post '/signup' do
    @user = BoardMember.create(params[:board_member])
  end

  get '/login' do
    erb :'/board-members/login'
  end

  post '/login' do
    @user = BoardMember.find_by(name: params[:name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/board-members/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/board-members' do
    @board_members = BoardMember.all
    erb :'/board-members/show_board_members'
  end

  get '/board-members/:slug' do
    if logged_in?
      @user = current_user
      erb :'/board-members/show_board_member'
    else
      redirect '/login'
    end
  end

  get '/board-members/:slug/edit' do
    @user = current_user
    erb :'/board-members/edit'
  end

  patch '/board-members/:slug' do
    user = BoardMember.find_by_slug(params[:slug])
    user.update(params[:board_member])
    redirect "/board-members/#{user.slug}"
  end

  get '/board-members/:slug/edit-committees' do
    @user = current_user
    @committees = Committee.all
    erb:'/board-members/edit_committees'
  end

  patch '/board-members/:slug/committees' do
    binding.pry
    user = BoardMember.find_by_slug(params[:slug])
    user.committee_ids = params[:committees]

    if !params[:new_committee].empty? && !Committee.find_by(name: params[:new_committee])
      new_committee = Committee.create(name: params[:new_committee])
      user.committees << new_committee
    end

    user.save
    redirect "/board-members/#{user.slug}"
    # binding.pry
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
