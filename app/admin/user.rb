ActiveAdmin.register User do
  permit_params :nickname, :role, :email

  scope :all, :default => true
  scope :banned do |users|
    users.where(banned: true)
  end
  scope :recent_users do |users|
    users.where("created_at > ?", 1.week.ago)
  end

  filter :nickname
  filter :email
  filter :role
  filter :banned
  filter :created_at
  filter :last_sign_in_at
  filter :last_sign_in_ip

  index do
    selectable_column
    id_column
    column :nickname
    column :email
    column :banned
    column :role
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    actions
  end

  show :title => :nickname do
    panel "Utauloids" do
      table_for(user.utauloids) do
        # column("Utauloid", :sortable => :id) {|utauloid| link_to "##{utauloid.id}", admin_utauloid_path(utauloid) }
        column("Utauloid", :sortable => :id) {|utauloid| "##{utauloid.id}" }
        column("Name") {|utauloid| utauloid.name }
        column("Date", :sortable => :created_at){|utauloid| pretty_format(utauloid.created_at) }
      end
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    inputs 'Details' do
      input :nickname
      input :email
      input :banned
      input :role, :as => :select, :collection => User.roles.keys.to_a.map { |u| [u.humanize, u] }
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end


end
