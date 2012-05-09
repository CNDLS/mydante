class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :description
      t.string :license
      t.timestamps
    end
  end
end
