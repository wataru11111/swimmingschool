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

  validate :limit_transfers_per_time_slot

  # 保存時にエラーが発生した場合の処理
  after_validation :reset_off_flag_on_error, if: -> { errors.any? }

  private

  # 同じクラス・時間帯の制限をチェック
  def limit_transfers_per_time_slot
    if Transfer.where(transfer_date: transfer_date, level: level, transfer_time: transfer_time).count >= 2
      errors.add(:base, "申し訳ございません。その日にちは人数に空きがないため振替ができません。別の日にち、時間帯で試してください。")
    end
  end

  # エラー時に関連するOffのflagをリセットする
  def reset_off_flag_on_error
    off&.reset_flag
  end
end
