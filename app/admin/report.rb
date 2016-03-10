ActiveAdmin.register Report do
  menu priority: 4

  actions :all, except: [:new, :create, :edit]
  filter :created_at
  config.sort_order = 'created_at_desc'

  index do
    column "Type", :reportable_type
    column "Reported object", :reportable_type do |report|
      link_to report.reportable.name, polymorphic_path([:admin, report.reportable])
    end
    column "Sent by", :user do |report|
      link_to report.user.nickname, admin_user_path(report.user)
    end
    column "Issued at", :created_at
    column "Last update", :updated_at
    actions defaults: false do |report|
      para link_to "Delete", admin_report_path(report), method: :delete
    end
  end

end
