class AvatarsController < InheritedResources::Base

  # GET /avatars/new
  def new
    @avatar = Avatar.new
  end

  # POST /avatars
  # POST /avatars.json
  def create
    previous_avatar = Avatar.find_by_user_id(current_user.id)
    if previous_avatar != nil
      Avatar.destroy(previous_avatar.id)
    end

    @avatar = Avatar.new(avatar_params, current_user.id)

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to @avatar, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @avatar }
      else
        format.html { render :new }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def avatar_params
      params.require(:avatar).permit(:image)
    end
end

