class CreateVectors < ActiveRecord::Migration
  def change
    create_table :vectors do |t|
      t.string :name
      t.string :value
      t.json :additions

      t.timestamps
    end
    add_index :vectors, :value
  end
end
