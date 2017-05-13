class PublicationsController < ApplicationController
  protect_from_forgery with: :null_session, only: :create

  def create
    # binding.pry
    @publication = Publication.create(
      { title: params[:data][:attributes][:job_offer][:title],
        description: params[:data][:attributes][:job_offer][:description]
      })
    @publication.save
  end
end
