class StaticPagesController < ApplicationController
  def home
    @carousel_images = Image.order("RANDOM()").limit(25)
  end
end
