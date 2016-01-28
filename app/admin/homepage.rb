ActiveAdmin.register_page "Homepage" do

  menu priority: 2

  content title: "Homepage" do
    homepage = Homepage.instance

    panel "Homepage settings" do
      panel "Showcase" do
        if homepage.utauloid_showcase.nil?
          para "Current showcased utauloid : none"
        else
          para do
            text_node "Current showcased utauloid : "
            text_node link_to(homepage.utauloid_showcase.name, admin_utauloid_path(homepage.utauloid_showcase))
          end
          para do
            text_node link_to "Change showcased utauloid in Utauloids page", admin_utauloids_path
          end
        end
      end
    end
  end

  # action_item :add do
  #   link_to "Utauloids", admin_utauloids_path
  # end

  # action_item :view_site do
  #   link_to "View Site", "/"
  # end

  # page_action :add_event do
  #   # ...
  #   redirect_to admin_utauloids_path, notice: "Your event was added"
  # end


end
