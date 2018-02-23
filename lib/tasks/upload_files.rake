# frozen_string_literal: true

# BEFORE USE THIS RAKE TASK BE SURE THAT YOU COMMENT LINE
# mount_uploader :image, ImageUploader
# validates_processing_of :image
# IN app/models/image.rb
# IF NOT - IT WILL BE nil IN DB images column: image

LOCAL_IMAGES_DIR = '~/Images'

namespace :upload_files do
  desc 'upload files when project is empty'
  task upload_files_from_local_dir: :environment do
    local_directory_path = File.expand_path(LOCAL_IMAGES_DIR)
    dir_array = Dir.entries(local_directory_path).reject { |entry| (entry == '.' || entry == '..') }
    dir_array.each do |dir_name|
      target_directory = Rails.root.join('public', 'uploads', dir_name)
      FileUtils.cp_r(local_directory_path + '/' + dir_name, target_directory, verbose: true)
      Category.create(name: dir_name)
    end
  end
end
