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
    @query_builder = QueryBuilder.new(@query.data)
    @limit = 100
    @query_builder.limit = @limit
    @results = Query.connection.select_all(@query_builder.to_sql)
    
    render :layout => false if request.xhr? 
  end
end
