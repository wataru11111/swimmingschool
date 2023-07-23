class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.integer  "child_id",           null: false
      t.string   "transfer date",      null: false
      t.string   "day off",            null: false
      t.integer  "transfer time",      null: false
      t.string   "telephone_number",   null: false
      t.string   "class",              null: false

      t.timestamps
    end
  end
end
