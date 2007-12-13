class Query::StartController < ApplicationController
  layout "tabs"
  def index
    @queries = Query.find(:all)
    redirect_to :action => "new" if @queries.blank?
  end
  
  def new
    @query = Query.new
  end
  
  def create
    @query = Query.new(params[:query])
    @query.project = current_project
    @query.data = {}
    @query.save
    
    redirect_to :controller => "query/select_models", :id => @query.id
  end
end
