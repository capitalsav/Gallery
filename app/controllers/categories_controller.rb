class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :create_image]
  before_action :authenticate_user!, only: [:new, :create, :new_image, :create_image]

  # GET /categories
  # GET /categories.json
  def index
    # TODO check for nil in image
    @categories_with_images = Category.all.map do |category| {category_key: category, image_key: category.images.order("RANDOM()").first} end
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, categories_path)
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, new_category_path)
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        #TODO check error NoMethodError in CategoriesController#create undefined method `category_url' for #<CategoriesController:0x007f26943a3a88> Did you mean? categories_url
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_images
    @category = Category.friendly.find_by_slug(params[:id])
    if user_signed_in?
      @subscription = @category.subscriptions.find_by(user_id: current_user.id)
      @images_with_likes = Category.friendly.find_by_slug(params[:id]).images.map do |image| {image_key: image, like_key: image.likes.find_by(user_id: current_user.id), likes_count_key: image.likes.count} end
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, single_category_path)
    else
      @images_with_likes = Category.friendly.find_by_slug(params[:id]).images.map do |image| {image_key: image, likes_count_key: image.likes.count} end
    end
  end

  def show_one_image
    @image = Category.friendly.find(params[:id]).images.find(params[:image_id])
    @likes_count = @image.likes.count
    @comments = @image.comments
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, single_category_image_path)
    end
  end

  def new_image
    @current_category = Category.friendly.find(params[:id])
    if @current_category.present?
      @image = Image.new
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, new_image_path)
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def create_image
    @image = @category.images.build(image_params)
    @image.user_id = current_user.id
    respond_to do |format|
      if @image.save
        format.html { redirect_to single_category_image_path(@category.slug, @image.id), notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { redirect_to :back }
        format.js {}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :user_id)
    end

    def image_params
      params.require(:image).permit(:image)
    end
end
