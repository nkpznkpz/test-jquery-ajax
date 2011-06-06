class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description      
      t.integer :group_id
      t.integer :user_id
      t.integer :priority
      t.boolean :star
      t.date :cr_date
      t.date :up_date
      #for url
      t.string :permalink
      #t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
