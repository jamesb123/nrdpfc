class QueryController < ApplicationController
  layout "tabs"
  def index
    @query = Query.new
  end
  
  def add_table
    
  end
  
  def new
  end
  
  def edit
  end
  
  def update
  end
  
  def show
    @query = Query.new(params[:query])
    @query_builder = QueryBuilder.new
  end
end
