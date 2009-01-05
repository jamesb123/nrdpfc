class VideosController < ApplicationController
  layout "tabs"
  def index
    @message = 'Help Videos'
  end
end
