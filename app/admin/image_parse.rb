ActiveAdmin.register_page "image_parse" do
  require 'open-uri'
  require 'timeout'

  VALID_URL_FIRST_CHARACTERS = 'http'

  page_action :parse, method: :get do
    begin
      Timeout.timeout(10) do
        @images = []
        Nokogiri::HTML(open(params['images-url'])).xpath('//img').each do |img|
          image = img['src']
          if image[0...4] == VALID_URL_FIRST_CHARACTERS
            @images.push(image)
          end
        end
        @categories = Category.all
        @users = User.all
        render partial: 'parsed_images'
      end
    rescue Timeout::Error
      render partial: 'parsed_images_error'
    end
  end

  content do
    form action: "image_parse/parse", method: :get do |f|
      f.input :url_field, type: :text, name: 'images-url'
      f.input :submit, type: :submit
    end
  end
end

