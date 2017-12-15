class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_admin_user!, only: [:edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.left_outer_joins(:likes).distinct.select('images.*, COUNT(likes.*) AS likes_count').group('images.id').order("likes_count DESC").map { |image| image.image.medium_thumb }
    # puts "================"
    # @images.each do |image|
    #   puts "-----"
    #   print image
    #   puts "-----"
    # end
    # puts "================"
    @images = @images.paginate(:page => params[:page], :per_page => 20)
      # @images.reject{|image| !image.image.medium_thumb.present? }
    # @images.each do |image|
    #   if !image.image.medium_thumb.present?
    #     @images.delete(image)
    #   end
    # end
    # @images = images.to_hash
    # @images.each do |image|
    #   if !image.image.medium_thumb.present?
    #     @images.delete(image)
    #   end
    # end
    # @images.delete_if {|img| !img.image.medium_thumb.present? }
  end

  # GET /images/1
  # GET /images/1.json
  def show
    # OPTIMIZE try to make it with joins
    @likes_count = @image.likes.count
    if user_signed_in?
      @like = @image.likes.find_by(user_id: current_user.id)
      comments = @image.comments.all
      @comments_with_users = []
      comments.each do |comment|
        my_hash = {}
        my_hash["comment"] = comment
        my_hash["user"] = comment.user
        @comments_with_users.push(my_hash)
      end
    end
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
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :image, :category_id)
    end
end
