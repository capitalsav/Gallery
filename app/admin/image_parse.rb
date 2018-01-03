ActiveAdmin.register_page "image_parse" do
  require 'open-uri'
  require 'timeout'

  VALID_IMAGE_URL_FIRST_CHARACTERS = 'http'

  page_action :parse, method: :get do
    begin
      timeout(10) do
        begin
          @images = []
          Nokogiri::HTML(open(params['images-url'])).xpath('//img').each do |img|
            image = img['src']
            if image[0...4] == VALID_IMAGE_URL_FIRST_CHARACTERS
              @images.push(image)
            end
          end
          render partial: 'parsed_images'
        rescue
          render partial: 'parsed_images_error'
        end
      end
    rescue Timeout::Error
      render partial: 'parsed_images_error'
    end
  end

  content do
    form action: "image_parse/parse", method: :get do |f|
      f.input :my_field, type: :text, name: 'images-url'
      f.input :submit, type: :submit
    end
  end
end
