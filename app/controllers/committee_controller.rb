class CommitteeController < ApplicationController
  get '/committees' do
    @committees = Committee.all
    erb :'/committees/show'
  end

  get '/committees/:slug' do
    @committee = Committee.find_by_slug(params[:slug])
    erb :'/committees/show_committee'
  end


end
