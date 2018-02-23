# frozen_string_literal: true

# Helper for devise
module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg, style: 'text-align: center;') }.join
    sentence = I18n.t('errors.messages.not_saved',
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="devise-errors" id="error_explanation">
      <h5>
        <p class="text-center">#{sentence}
      </h5>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
