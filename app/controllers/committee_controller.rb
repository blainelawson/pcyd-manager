class CommitteeController < ApplicationController
  get '/committees' do
    @committees = Committee.all
    erb :'/committees/show'
  end

  get '/committees/:slug' do
    @committee = Committee.find_by_slug(params[:slug])
    erb :'/committees/show_committee'
  end

  get '/committees/:slug/edit' do
    if logged_in? && current_user == Committee.find_by_slug(params[:slug]).board_member
      @committee = Committee.find_by_slug(params[:slug])
      @members = Member.all
      erb :'/committees/edit_committee'
    else
      redirect "/committees"
    end
  end

  patch '/committees/:slug' do
    if logged_in? && current_user == Committee.find_by_slug(params[:slug]).board_member
      committee = Committee.find_by_slug(params[:slug])
      committee.member_ids = params[:members]
      committee.save
      redirect "/committees/#{params[:slug]}"
    else
      redirect '/committees'
    end
  end
end
