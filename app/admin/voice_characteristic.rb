ActiveAdmin.register VoiceCharacteristic do
  permit_params :name

  filter :name

  index do
    selectable_column
    column :name
    actions defaults: false do |vc|
      link_to "Edit", edit_admin_voice_characteristic_path(vc) #TODO : h4lp
      link_to "Delete", admin_voice_characteristic_path(vc), method: :delete, data: { confirm: "Really delete #{vc.name}?" }
    end
  end

  show :title => :name do
    panel "Info" do
      attributes_table_for category do
        row :name
        row :created_at
        row :updated_at
      end
    end

    panel "Utauloids" do
      table_for category.utauloids do
        column :id
        column :name do |u| 
          link_to u.name, admin_utauloid_path(u)  
        end
        column :created_at
      end
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Category' do
      f.input :name
    end
    f.actions
  end


  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end