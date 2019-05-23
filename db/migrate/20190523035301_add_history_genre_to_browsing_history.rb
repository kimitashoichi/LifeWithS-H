class AddHistoryGenreToBrowsingHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :browsing_histories, :history_genre, :string
  end
end
