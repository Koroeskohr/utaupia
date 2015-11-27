class ImageController < ApplicationController
  def index
  end

  def new
  	@image = Image.new
  end

  def create
  	@image = Image.create( image_params )
    @image.save

    redirect_to image_index_path
  end

  def show
  	@image = Image.find(params[:id])
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.
  def image_params
    params.require(:image).permit(:img)
  end
end
