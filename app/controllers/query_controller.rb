class QueryController < ApplicationController
  def index
    session[:query] ||= @query = Query.new
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
    
  end
end
