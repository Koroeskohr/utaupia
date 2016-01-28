ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent reports" do
          ul do
            Report.last(5).map do |report|
              li link_to report.reportable.name, polymorphic_path([:admin, report.reportable])
            end
          end
        end
      end

      column do
        panel "Stats" do
          ul do
            li "#{User.count} users"
            li "#{VoiceBank.count} voice banks over #{Utauloid.count} utauloids"
          end
        end
      end
    end # top row

    columns do
      column do
        panel "Last 10 utauloids added" do
          ul do
            Utauloid.last(10).map do |utauloid|
              li link_to utauloid.name, admin_utauloid_path(utauloid)
            end
          end
        end
      end

      column do
        panel "Last 10 users registered" do
          ul do
            User.last(10).map do |user|
              li link_to user.nickname, admin_user_path(user)
            end
          end
        end
      end
    end # bottom row
  end # content
end
