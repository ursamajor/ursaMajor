class ApiController < ApplicationController
  respond_to :json

  def index
    respond_to do |format|
      format.html
      format.json { render 'api_docs.json' }
    end
  end

  def api_doc
    respond_to do |format|
      format.json { render "api/#{params[:title]}.json"}
    end
  end

end
