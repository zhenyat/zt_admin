class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.integer :role,            null: false, default: 0, limit: 1
      t.string  :last_name,       null: false
      t.string  :first_name,       null: false
      t.string  :email,           null: false, index: {unique: true}
      t.string  :password_digest, null: false
      t.string  :remember_digest
      t.integer :status,          null: false, default: 0, limit: 1  # default: active

      t.timestamps null: false
    end
  end
end
