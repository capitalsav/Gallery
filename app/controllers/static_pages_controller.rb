class StaticPagesController < ApplicationController
  def home
    images_array = Image.order("RANDOM()").limit(5)
    uploaded = true
    if images_array.present?
      @carousel_images = {:images_uploaded => uploaded, :images => images_array}
    else
      uploaded = false
      # static_image = "/assets/default.jpg"
      static_image = "default.jpg"
      @carousel_images = {:images_uploaded => uploaded, :images => static_image}
    end
  end
end
