class CreateTextSelections < ActiveRecord::Migration
  def change
    create_table :text_selections do |t|
      t.integer :book_id
      t.integer :page_nbr
      t.integer :line_nbr
      t.integer :user_id
      t.integer :media_id
      
      t.timestamps
    end
  end
end
