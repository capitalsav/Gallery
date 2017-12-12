class AvatarsController < InheritedResources::Base

  # GET /avatars/new
  def new
    @avatar = Avatar.new
  end

  # POST /avatars
  # POST /avatars.json
  def create
    # previous_avatar = Avatar.find_by_user_id(current_user.id)
    # if previous_avatar != nil
    #   Avatar.destroy(previous_avatar.id)
    # end
    @avatar_obj = Avatar.new(avatar_params)
    puts"===================================="
    puts avatar_params
    puts"===================================="
    respond_to do |format|
      if @avatar_obj.save
        avatar_uploaded = true
        @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => @avatar_obj}
        format.html { redirect_back fallback_location: root_path }
        format.js  #render :show, status: :created, location: @avatar
      else
        avatar_uploaded = false
        default_image = "/assets/default_avatar.png"
        #TODO use below for production
        # default_image = "default_avatar.png"
        @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => default_image}
        format.html { redirect_back fallback_location: root_path }
        format.js
      end
    end
  end

  # PATCH/PUT /avatars/1
  # PATCH/PUT /avatars/1.json
  def update
    @avatar = Avatar.find_by_user_id(current_user.id)
    respond_to do |format|
      if @avatar.update(avatar_params)
        format.html { redirect_back fallback_location: root_path }
        format.js  #render :show, status: :created, location: @avatar
      else
        format.html { redirect_back fallback_location: root_path }
        format.js
      end
    end
  end

  private

    def avatar_params
      params.require(:avatar).tap do |hash|
        hash[:current_user] = current_user
      end
      params.require(:avatar).permit(:image, :current_user)
    end
end

