class CreateEdits < ActiveRecord::Migration
  def change
    create_table :edits do |t|
      t.integer :subject_id
      t.string :subjet_type
      t.integer :editor_id

      t.timestamps
    end
  end
end
