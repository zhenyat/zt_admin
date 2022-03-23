class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string  :name,        null: false, index: {unique: true}
      t.string  :title,       null: false, index: {unique: true}
      t.string  :abstract,    null: false, index: {unique: true}
      t.integer :position
      t.integer :status,      null: false, default: 0, limit: 1  # default: active
      t.string  :url,         null: false, index: {unique: true}
      t.string  :seo_title,   null: false, index: {unique: true}, limit:  70 # 50-70 characters
      t.string  :seo_description,                                 limit: 160 # 50-160 characters

      t.timestamps
    end
  end
end

# % r g model Category name title abstract position:integer status:integer url seo_title:string{70} seo_description:string{160}