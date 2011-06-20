class CreateMetaDatas < ActiveRecord::Migration
  def self.up
    create_table :meta_datas do |t|
       t.column :project_id, :integer 
       t.column :m_name, :string
       t.column :m_desc, :string
       t.column :m_author, :string
       t.column :m_date_added, :datetime
       t.column :m_document_name, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :meta_datas
  end
end
