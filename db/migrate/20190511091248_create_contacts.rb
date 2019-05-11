class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :contact_title
      t.text :contact_text
      t.text :contact_email
      t.integer :user_id

      t.timestamps
    end
  end
end
