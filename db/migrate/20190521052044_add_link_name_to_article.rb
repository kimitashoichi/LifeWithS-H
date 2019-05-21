class AddLinkNameToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :link_name, :string
  end
end
