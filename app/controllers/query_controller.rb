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

  def import
    @messages = []

    if request.post? && !params[:model].blank? && !params[:import_file].blank? 
      if CsvImporter::IMPORT_TABLES.include?(params[:model])
        klass = Object.const_get(params[:model].singularize.camelcase)

        importer = CsvImporter.new(params[:import_file].read, klass)
        importer.overwrite = true unless params[:overwrite].blank?
        importer.import_records if importer.valid?

        @messages = (importer.errors.empty? ? [ "Import successfull" ] : importer.errors)
      else
        @messages = [ "Invalid model selection" ]
      end
    end
  end
  
  skip_filter :login_required, :only => [ :georss, :download_csv ]
  def download_csv
    @stored_query = DataQuery.query_by_key(params[:key])

    if params[:key].blank? || @stored_query.nil?
      render :text => ""
    else
      self.current_project = @stored_query.project
      @query = Query.new(:data => @stored_query.data)
      @query_builder = @query.query_builder

      tmpfile = Tempfile.new('qbcsv-' + params[:key])
      begin
        @query_builder.to_csv FasterCSV.new(tmpfile)
      ensure
        tmpfile.close
      end

      send_file tmpfile.path, :filename => 'query_results.csv'
    end
  end

  def save_query
    begin
      @query = DataQuery.create!(:data => params[:data], :project => current_project)

      render :layout => false if request.xhr? 
    rescue ActiveRecord::RecordInvalid
      render :text => "Empty queries will not return any data. Please add fields and/or conditions."
    end
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
