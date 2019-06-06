class MemberController < ApplicationController

  get '/members' do
    # binding.pry
      @members = Member.all
      erb :'/members/show_members'
  end

  get '/members/new' do
    erb :'/members/create_member'
  end

  get '/members/:slug' do
    @member = Member.find_by_slug(params[:slug])
    erb :'members/show_member'
  end

  get '/members/:slug/edit' do
    @member = Member.find_by_slug(params[:slug])
    erb :'/members/edit_member'
  end

  post '/members' do
    member = Member.create(params[:member])
    redirect "/members/#{member.slug}"
  end

  patch '/members/:slug' do
    @member = Member.find_by_slug(params[:slug])
    @member.update(params[:member])
    redirect "/members/#{@member.slug}"
  end
end
