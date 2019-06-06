class MemberController < ApplicationController

  get '/members' do
      @members = Member.all
      erb :'/members/show_members'
  end

  get '/members/new' do
    if logged_in?
      erb :'/members/create_member'
    else
      redirect '/login'
    end
  end

  get '/members/:slug' do
    if logged_in?
      @member = Member.find_by_slug(params[:slug])
      erb :'members/show_member'
    else
      redirect '/login'
    end
  end

  get '/members/:slug/edit' do
    if logged_in?
      @member = Member.find_by_slug(params[:slug])
      erb :'/members/edit_member'
    else
      redirect '/login'
    end
  end

  post '/members' do
    if logged_in?
      member = Member.create(params[:member])
      redirect "/members/#{member.slug}"
    else
      redirect '/members'
    end
  end

  patch '/members/:slug' do
    if logged_in?
      @member = Member.find_by_slug(params[:slug])
      @member.update(params[:member])
      redirect "/members/#{@member.slug}"
    else
      redirect '/login'
    end
  end
end
