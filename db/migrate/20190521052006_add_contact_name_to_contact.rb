class AddContactNameToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :contact_name, :string
  end
end
