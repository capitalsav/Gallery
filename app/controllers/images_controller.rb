# frozen_string_literal: true

# Controller for images
class ImagesController < ApplicationController
  skip_before_action :user_click, only: [:create,
                                         :edit,
                                         :update,
                                         :destroy,
                                         :upload_remote]
  before_action :set_image, only: [:edit, :update, :destroy]
  before_action :set_show, only: :show
  before_action :set_category, only: :create
  before_action :authenticate_user!,
                only: [:new, :create],
                unless: :current_admin_user

  # GET /images
  # GET /images.json
  def index
    @images = Image.left_outer_joins(:likes).distinct.select(
      'images.*, COUNT(likes.*) AS likes_count'
    ).group(
      'images.id'
    ).order('likes_count DESC').map { |image| image.image.medium_thumb }
    @images = Kaminari.paginate_array(@images).page(params[:page])
  end

  # GET /images/1
  # GET /images/1.json
  def show; end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  # POST /images.json
  def create
    @image = @category.images.build(image_params)
    respond_to do |format|
      if @image.save!
        Resque.enqueue(NewImageNotificationJob,
                       @image.category,
                       @image,
                       Category.find(@category.id).subscribed_users)
        flash[:success] = t('.image_created')
        format.html do
          redirect_to single_category_image_path(@category.slug, @image.id)
        end
        format.json { render :show, status: :created, location: @image }
      else
        format.html { redirect_back fallback_location: root_path }
        format.js {}
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @category = Category.friendly.find(params[:image][:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def image_params
    params.require(:image).permit(:image,
                                  :remote_image_url,
                                  :category_id,
                                  :user_id)
  end

  def set_show
    @image = Category.friendly.find(params[:id]).images.find(params[:image_id])
    @like = @image.likes.find_by(user_id: current_user.id) if user_signed_in?
  end
end
