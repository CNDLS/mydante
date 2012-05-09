class AddSourceToImages < ActiveRecord::Migration
  
  def self.up
    add_column :media, :source_id, :integer
  end

  def self.down
    remove_column :media, :source_id
  end
end
