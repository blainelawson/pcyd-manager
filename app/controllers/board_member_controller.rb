

class BoardMemberController < ApplicationController

  get '/signup' do
    erb :'board-members/create_board_member'
  end

  post '/signup' do

    if BoardMember.create(params[:board_member]).valid?
      @user = BoardMember.last
      session[:user_id] = @user.id

      if logged_in?
        if !Member.find_by(name: @user.name)
          Member.create(name: @user.name, email: @user.email, phone: @user.phone)
        end
        redirect "/board-members/#{@user.slug}"
      else
        redirect '/signup'
      end
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/board-members/login'
  end

  post '/login' do
    @user = BoardMember.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/board-members/#{@user.slug}"
    else
      flash[:message] = "Could not log you in with that information"
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
      not_logged_in_and_current_user

      @user = current_user
      erb :'/board-members/edit'
  end

  patch '/board-members/:slug' do
    user = BoardMember.find_by_slug(params[:slug])

    if logged_in? && user.authenticate(params[:board_member][:password])
      user.update(params[:board_member])
      redirect "/board-members/#{user.slug}"
    else
      flash[:message] = "Something went wrong"
      redirect "/board-members/#{params[:slug]}/edit"
    end
  end

  get '/board-members/:slug/edit-committees' do
    if logged_in?  && current_user == BoardMember.find_by_slug(params[:slug])
      @user = current_user
      @committees = Committee.all
      erb:'/board-members/edit_committees'
    else
      flash[:message] = "You do not have permission"

      redirect '/login'
    end
  end

  patch '/board-members/:slug/committees' do
    user = BoardMember.find_by_slug(params[:slug])

    if logged_in? && current_user == user
      user.committee_ids = params[:committees]

      if !params[:new_committee].empty? && !Committee.find_by(name: params[:new_committee])
        new_committee = Committee.create(name: params[:new_committee])
        user.committees << new_committee
      end

      user.save
      redirect "/board-members/#{user.slug}"
    else
      flash[:message] = "You do not have permission"
      redirect '/board-members/show_board_member'
    end
  end

  delete '/board-members/:slug/delete' do
    board_member = BoardMember.find_by_slug(params[:slug])

    if logged_in? && current_user == board_member
      board_member.delete
      session.clear
      redirect '/'
    else
      flash[:message] = "You do not have permission"
      redirect '/login'
    end
  end

end
