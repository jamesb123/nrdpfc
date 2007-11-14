require File.join(File.dirname(__FILE__), 'fixtures/document')

ActiveRecord::Schema.define(:version => 0) do
  create_table :pages, :force => true do |t|
    t.column :name, :string, :null => false
  end

  create_table :page_attributes, :force => true do |t|
    t.column :page_id, :integer, :null => false
    t.column :name, :string, :null => false
    t.column :value, :string, :null => false
  end

  create_table :users, :force => true do |t|
    t.column :name, :string, :null => false
    t.column :email, :string
  end

  create_table :preferences, :force => true do |t|
    t.column :user_id, :integer, :null => false
    t.column :key, :string, :null => false
    t.column :value, :string, :null => false
  end

  create_table :user_contact_infos, :force => true do |t|
    t.column :contact_id, :integer, :null => false
    t.column :name, :string, :null => false
    t.column :value, :string, :null => false
  end

  create_table :documents, :force => true do |t|
    t.column :name, :string, :null => false
    t.column :version, :integer, :null => false
  end
  drop_table :document_versions rescue nil
  Document.create_versioned_table

  create_table :document_attributes, :force => true do |t|
    t.column :document_id, :integer, :null => false
    t.column :name, :string, :null => false
    t.column :value, :string, :null => false
    t.column :version, :integer, :null => false
  end
  drop_table :document_attribute_versions rescue nil
  DocumentAttribute.create_versioned_table

  create_table :document_document_attributes_versions, :id => false, :force => true do |t|
    t.column :document_version_id, :integer, :null => false
    t.column :document_attribute_version_id, :integer, :null => false
  end
end