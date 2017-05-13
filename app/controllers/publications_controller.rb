class PublicationsController < ApplicationController
  protect_from_forgery with: :null_session, only: :create


  def index
    @publications = Publication.all
  end

  def create
    # binding.pry
    @publication = Publication.create(
      { title: params[:data][:attributes][:job_offer][:title],
        description: params[:data][:attributes][:job_offer][:description]
      })

    if @publication.save
      head :created
    else
      head :no_content
    end
  end
end
