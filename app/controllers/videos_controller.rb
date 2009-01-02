class VideosController < ApplicationController
#  <%= swfobject_tag "flash.swf", :div_id => "id_of_div"  %>

  def index
    @message = 'Video Listing'
  end
end
