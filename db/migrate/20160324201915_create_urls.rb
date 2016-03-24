class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
    	t.boolean :success, :default => false
    	t.string :long
    	t.string :short
    	t.integer :visits, :default => 0

      t.timestamps null: false
    end
  end
end
