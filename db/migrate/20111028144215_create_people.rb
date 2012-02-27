class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string   "first_name",                              :default => ""
      t.string   "last_name",                               :default => ""
      t.timestamps
    end
  end
end
