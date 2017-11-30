class StaticPagesController < ApplicationController
  def home
    # @carousel_images = Image.order("RANDOM()").limit(5)
    @carousel_images = Image.order("RANDOM()").limit(0)
    unless @carousel_images.present?
      image_path = "default.jpg"
      image = Image.new
      image.image = image_path
      @carousel_images = [image]
    end
  end
end
