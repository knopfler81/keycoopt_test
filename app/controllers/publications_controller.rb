class PublicationsController < ApplicationController
  protect_from_forgery with: :null_session, only: :create


  def show
    @publication = Publication.find(params[:id])
  end

  def index
    @publications = Publication.all
    @publications = Publication.order('created_at DESC')
    @publications = @publications.page params[:page]
  end

  def create
    @publication = Publication.create(
      { title: params[:data][:attributes][:job_offer][:title],
        description: params[:data][:attributes][:job_offer][:description],
        customer: params[:data][:attributes][:job_offer][:customer][:name]
      })

    if @publication.save
      head :created
    else
      head :no_content
    end
  end
end
