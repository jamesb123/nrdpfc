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
  
  def download_csv
    @query = Query.new(:data => params[:data])
    @query_builder = @query.query_builder
    @results = Query.connection.select_all(@query_builder.to_sql)
    uniq_id = (rand * 10000000).to_i
    
    @filename = "/download/results_#{uniq_id}.csv"
    @abs_filename = "#{RAILS_ROOT}/public#{@filename}"
    FasterCSV.open(@abs_filename, "w") do |csv|
      csv << @query_builder.select_field_aliases.map(&:titleize)
      
      @results.each do |result|
        csv << @query_builder.select_field_aliases.map{ |col| result[col]}
      end
    end
    
    render :update do |page|
      page << "window.open('#{@filename}')"
    end
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
