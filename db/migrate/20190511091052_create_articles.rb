class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :movie_url
      t.text :article_url
      t.string :article_title
      t.text :article_text
      t.text :article_url
      t.text :article_image
      t.string :genre

      t.timestamps
    end
  end
end
