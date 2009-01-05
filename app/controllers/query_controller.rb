class QueryController < ApplicationController
  layout "tabs"

  def index
    @query = Query.new
  end
  
  def add_table
    
  end
  
  def add_field
    @query_table = QueryTable.new(params[:table])
    if params[:field]
      @query_fields = [@query_table.add_field(params[:field])]
    else
      @query_fields = @query_table.model.exportable_fields.map {|f| @query_table.add_field(f) }
    end
  end
  
  def add_filter
    @query_table = QueryTable.new(params[:table])
    @query_field = @query_table.add_field(params[:field])
  end
  
  def new
  end
  
  def edit
  end
  
  def update
  end
  
  skip_filter :login_required, :only => [ :georss, :download_csv ], :if => Proc.new { !params[:key].blank? }
  def download_csv
    if params[:key].blank?
      @query = Query.new(:data => params[:data])
    else
      @stored_query = DataQuery.query_by_key(params[:key])
      self.current_project = @stored_query.project

      @query = Query.new(:data => @stored_query.located_query)
    end

    unless @query.nil?
      @query_builder = @query.query_builder

      uniq_id = (rand * 10000000).to_i
      @filename = "/download/results_#{uniq_id}.csv"
      @abs_filename = "#{RAILS_ROOT}/public#{@filename}"

      FasterCSV.open(@abs_filename, "w") do |csv|
        csv << @query_builder.column_headers
        @query_builder.results.each {|result| csv << result }
      end
      
      redirect_to(@filename)
    end
  end

  def save_query
    @query = DataQuery.create!(:data => params[:data], :project => current_project)

    render :layout => false if request.xhr? 
  end

  def georss
    @stored_query = DataQuery.query_by_key(params[:key])

    if params[:key].blank? || @stored_query.nil?
      render :text => ""
    else
      self.current_project = @stored_query.project

      @query = Query.new(:data => @stored_query.located_query)
      @query_builder = @query.query_builder
      @query_builder.limit = 500
      @results = Query.connection.select_all(@query_builder.to_sql)

      unless params[:download].blank?
        filename = "#{self.current_project.name.gsub(/ /, '')}_map_data.xml"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end

      render :layout => false
    end
  end
  
  def show
    @query = Query.new(:data => params[:data])
    @query_builder = @query.query_builder
    @limit = 100
    @query_builder.limit = @limit
    @sql = @query_builder.to_sql
    @results = Query.connection.select_all(@sql)
    
    render :layout => false if request.xhr? 
  end
end
