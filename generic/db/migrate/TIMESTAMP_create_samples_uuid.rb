class CreateSamples < ActiveRecord::Migration[6.1]
  def change
    create_table :samples, id: :uuid do |t|
      t.string  :name,     null: false
      t.string  :title,    null: false
      t.decimal :price,    null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.integer :position
      t.integer :status,   null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
    add_index :samples, :name,  unique: true
  end
end
