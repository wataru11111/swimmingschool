class Off < ApplicationRecord
  belongs_to :child
  has_many :transfers, foreign_key: :off_id

  # バリデーション
  validates :off_day, uniqueness: { scope: [:child_id, :off_month], message: "この日は既に登録されています。一度ページを再読み込みしてから別の日にちを指定してください。" }

  # 振替済みかどうかを判定するメソッド
  def transfer_registered?
    transfers.exists?
  end

  # 振替済みのTransferデータを取得するメソッド
  def registered_transfer
    transfers.first
  end

  # 振替データが関連付けられていない場合、flagをデフォルトの状態に戻す
  def reset_flag_if_no_transfer
    if transfers.empty? && flag != 0
      update(flag: 0)
      Rails.logger.debug "Reset flag for Off ID=#{id} because no related transfers found."
    end
  end
end
