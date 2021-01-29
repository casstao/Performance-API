class CreateCages < ActiveRecord::Migration[5.2]
  def change
    create_table :cages do |t|

      t.integer :max_capacity
      t.integer :current_capacity
      t.string :status
      t.string :cage_type
      

      t.timestamps
    end
  end
end
