class QueryController < ApplicationController
  layout "tabs"
  def index
    @query = Query.new
  end
  
  def add_table
    
  end
  
  def get_table_field
    @query_table = QueryTable.new(params[:table])
    @query_field = @query_table.add_field(params[:field])
  end
  
  def add_field
    get_table_field
  end
  
  def add_filter
    get_table_field
  end
  
  def new
  end
  
  def edit
  end
  
  def update
  end
  
  def show
    @query = Query.new(:data => params[:data])
    @query_builder = @query.query_builder
    @limit = 100
    @query_builder.limit = @limit
    @results = Query.connection.select_all(@query_builder.to_sql)
    
    render :layout => false if request.xhr? 
  end
end
