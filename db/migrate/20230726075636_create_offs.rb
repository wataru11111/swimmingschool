class CreateOffs < ActiveRecord::Migration[6.1]
  def change
    create_table :offs do |t|
      t.integer  "child_id",           null: false
      t.integer  "off_day",            null: false
      t.string   "level",              null: false
      t.string  "flag",                null: false
      t.string   "last_name",       null: false
      t.string   "first_name",        null: false
      t.string   "contact_time",       null: false
      t.string   "contact_dey",        null: false

      t.timestamps
    end
  end
end
