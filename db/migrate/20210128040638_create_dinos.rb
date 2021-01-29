class CreateDinos < ActiveRecord::Migration[5.2]
  def change
    create_table :dinos do |t|
      t.string :name
      t.string :species
      t.string :dino_type
      t.belongs_to :cage, index: true
      t.timestamps
    end
  end
end
