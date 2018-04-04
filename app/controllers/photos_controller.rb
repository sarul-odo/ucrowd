class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    send_data(@photo.data,
                :filename => @photo.name,
                :type => @photo.content_type,
                :disposition => "inline")
 end
end
