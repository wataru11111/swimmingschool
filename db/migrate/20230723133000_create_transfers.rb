class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.integer  "child_id",           null: false
      t.string   "off_id",             null: false
      t.integer  "transfer_month",     null: false
      t.date     "transfer_date",      null: false
      t.integer  "transfer_day",       null: false
      t.string   "transfer_time",      null: false
      t.string   "telephone_number",   null: false
      t.string   "level",              null: false
      t.string   "contact_dey",        null: false # 新しく追加したカラム

      t.timestamps
    end
  end
end
