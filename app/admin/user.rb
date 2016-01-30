ActiveAdmin.register User do
  menu priority: 2
  config.batch_actions = false

  actions :all, except: [:destroy, :new, :create]

  permit_params :nickname, :role, :email, :banned, 
    user_info_attributes: [ :id, :avatar, :description ]

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
    column :banned do |user| 
      user.banned ? status_tag("red", label: "Yes") : status_tag("No")
    end
    column :role do |user| 
      user.role.titleize 
    end
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    actions defaults: false do |user|
      para link_to "View", admin_user_path(user)
      para link_to "Edit", edit_admin_user_path(user)
    end
  end

  show :title => :nickname do
    panel "User info" do
      div do
        status_tag("red", label: "Banned") if user.banned
      end
      attributes_table_for user do
        row('Description') { user.user_info.description }
      end

      table_for user.user_info.user_links do
        column('Link') { |user_link| link_to user_link.link, user_link.link } 
      end
    end
    panel "Utauloids" do
      table_for(user.utauloids) do
        column("Utauloid", :sortable => :id) {|utauloid| link_to "##{utauloid.id}", admin_utauloid_path(utauloid) }
        column("Name") {|utauloid| utauloid.name }
        column("Date", :sortable => :created_at){|utauloid| pretty_format(utauloid.created_at) }
      end
    end
  end

  sidebar "User Details", :only => :show do
    attributes_table_for user do
      row('Avatar') { image_tag user.user_info.avatar.url(:thumb) }
      row('Nickname') { user.nickname }
      row('Email') { user.email }
      row('Created at') { pretty_format(user.created_at) }
    end

    if user.banned?
      link_to 'Unban user', user_unban_path(user), :data => { confirm: "Do you really want to unban #{user.nickname}?" }
    else
      link_to 'Ban user', user_ban_path(user), :data => { confirm: "Do you really want to ban #{user.nickname}?" }
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Details' do
      input :nickname
      input :email
      input :banned
      input :role, :as => :select, :collection => User.roles.keys.to_a.map { |u| [u.humanize, u] }
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end

    f.inputs do
      f.has_many :user_info, heading: 'User info', new_record: false do |u|
        u.input :description
        u.input :avatar, as: :file, hint: image_tag(user.user_info.avatar.url)
        u.has_many :user_links, allow_destroy: true, new_record: false do |ul|
          ul.input :link
        end
      end
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end


end
