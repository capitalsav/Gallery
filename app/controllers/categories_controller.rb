class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :create_image]

  # GET /categories
  # GET /categories.json
  def index
    # OPTIMIZE try to make it with joins
    categories = Category.all
    @categories_with_images = []
    categories.each do |category|
      my_hash = {}
      my_hash["category_key"] = category
      my_hash["image_key"] = category.images.order("RANDOM()").first
      @categories_with_images.push(my_hash)
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
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
    @category = Category.find_by_name(params[:name])
    @subscription = @category.subscriptions.find_by(user_id: current_user.id)
    # OPTIMIZE try to make it with joins
    images = Category.find_by_name(params[:name]).images
    @images_with_likes = []
    if user_signed_in?
      images.each do |image|
        my_hash = {}
        my_hash["image_key"] = image
        my_hash["like_key"] = image.likes.find_by(user_id: current_user.id)
        my_hash["likes_count_key"] = image.likes.count
        @images_with_likes.push(my_hash)
      end
    else
      images.each do |image|
        my_hash = {}
        my_hash["image_key"] = image
        my_hash["likes_count_key"] = image.likes.count
        @images_with_likes.push(my_hash)
      end
    end
  end

  def show_one_image
    # OPTIMIZE try to make it with joins
    @image = Category.find_by_name(params[:name]).images.find(params[:image_id])
    @likes_count = @image.likes.count
    if user_signed_in?
      comments = @image.comments.all
      @like = @image.likes.find_by(user_id: current_user.id)
      @comments_with_users = []
      comments.each do |comment|
        my_hash = {}
        my_hash["comment"] = comment
        my_hash["user"] = comment.user
        @comments_with_users.push(my_hash)
      end
    end
  end

  def new_image
    @current_category = Category.find_by(id: params[:id], name: params[:name])
    if @current_category.present?
      @image = Image.new
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def create_image
    @image = @category.images.build(image_params)
    @image.user_id = current_user.id
    respond_to do |format|
      if @image.save
        format.html { redirect_to single_category_image_path(@category.name, @image.id), notice: 'Image was successfully created.' }
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
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :user_id)
    end

    def image_params
      params.require(:image).permit(:image)
    end
end
