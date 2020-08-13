class CreateCharactersTable < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :class
      t.string :race 
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence 
      t.integer :wisdom
      t.integer :charisma
    end

  end
end
