class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.column :user_id, :integer
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :province, :string
      t.column :postal, :string
      t.column :phone, :string
      t.column :mobile, :string
      t.column :fax, :string
      t.column :email, :string
      t.column :payment_method, :string
      t.column :credit_card, :string
      t.column :purchase_order, :string
      t.column :overdue, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
