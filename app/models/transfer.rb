class Transfer < ApplicationRecord
  belongs_to :child
  belongs_to :off, foreign_key: :off_id

  validates :last_name, presence: { message: "苗字を入力してください。" }
  validates :first_name, presence: { message: "名前を入力してください。" }
  validates :transfer_date, presence: { message: "振替日を選択してください。" }
  validates :level, presence: { message: "クラスを選択してください。" }
  validates :contact_dey, presence: { message: "振替曜日を選択してください。" }
  validates :transfer_time, presence: { message: "振替時間を選択してください。" }
  validates :telephone_number, presence: { message: "電話番号を入力してください。" },
            format: { with: /\A\d{10,11}\z/, message: "電話番号はハイフンなしで入力してください。" }
end
