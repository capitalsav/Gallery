require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET index" do
    it "assigns @categories_with_images" do
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
