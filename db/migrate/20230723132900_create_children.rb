class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.integer "customer_id",        null: false
        t.string "last_name",         null: false
        t.string "first_name",        null: false
        t.string "last_name_kana",    null: false
        t.string "first_name_kana",   null: false
        t.integer "contact time",     null: false
        t.string "contact dey",       null: false
        t.string "class",             null: false

      t.timestamps
    end
  end
end