class ImagesController < ApplicationController
  skip_before_action :user_click, only: [:create, :edit, :update, :destroy, :upload_remote]
  before_action :set_image, only: [:edit, :update, :destroy]
  before_action :set_show, only: [:show]
  before_action :set_category, only: [:create]
  before_action :authenticate_user!, only: [:new, :create], unless: :current_admin_user

  # GET /images
  # GET /images.json
  def index
    @images = Image.left_outer_joins(:likes).distinct.select('images.*, COUNT(likes.*) AS likes_count').group(
        'images.id').order("likes_count DESC").map { |image| image.image.medium_thumb }
    @images = Kaminari.paginate_array(@images).page(params[:page])
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = @category.images.build(image_params)
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

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    def set_category
      begin
        @category = Category.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @category = Category.friendly.find(params[:image][:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image, :remote_image_url, :category_id, :user_id)
    end

    def set_show
      @image = Category.friendly.find(params[:id]).images.find(params[:image_id])
      if user_signed_in?
        @like = @image.likes.find_by(user_id: current_user.id)
      end
    end
end
