ActiveAdmin.register VoicebankType do
  permit_params :name

  filter :name

  index do
    selectable_column
    column :name
  end

  show :title => :name do
    panel "Info" do
      attributes_table_for voicebank_type do
        row :name
        row :created_at
        row :updated_at
      end
    end

    panel "Utauloids" do
      table_for voicebank_type.utauloids do
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
    f.inputs 'Voice Bank Type' do
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