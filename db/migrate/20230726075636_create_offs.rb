class CreateOffs < ActiveRecord::Migration[6.1]
  def change
    create_table :offs do |t|
      t.date     "off_month"        # 月を保存するカラム
      t.date     "off_day"          # 日を保存するカラム
      t.integer  "child_id",        null: false
      t.string   "level",           null: false
      t.string   "flag",            null: false
      t.string   "last_name",       null: false
      t.string   "first_name",      null: false
      t.string   "contact_time",    null: false
      t.string   "contact_dey",     null: false
      t.timestamps
    end
     # 一意性を確保するインデックスを追加
    add_index :offs, [:child_id, :off_day], unique: true, name: 'index_offs_on_child_id_and_off_day'
  end
end
