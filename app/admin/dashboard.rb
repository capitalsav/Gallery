ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Comments" do
          table_for Comment.joins(:user).joins(:image).order("id desc").limit(5).map do
            column("Text"){|comment| comment.text}
            column("User"){|comment| comment.user.email}
            column("Image"){|comment| link_to "Image link", single_category_image_path(comment.image.category.name, comment.image.id) }
          end
        end
      end
    end
  end # content
end
