class Query::SelectModelsController < ApplicationController
  def index
    
  end
  # Idea for implementation
  # store everything in a hash, similarly how he would pass a includes hash into active record #find
  # every time that they click a relationship, it fires an ajax request which refreshes the entire tree, with the ad rqeuest, along with the serialized includes data
  # 
{
  :organisms => {
    :samples => ""
  }
}
  def select_models
    
  end
end
