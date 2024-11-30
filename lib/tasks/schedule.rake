namespace :off do
  desc "Check and update expiration status for Off records"
  task check_expiration: :environment do
    puts "期限切れチェックを開始します..."

    expired_count = 0

    Off.where(flag: 0).find_each do |off|
      if off.expired?
        off.check_and_update_expiration
        expired_count += 1
      end
    end

    puts "#{expired_count} 件の 'Off' レコードが期限切れとして更新されました。" if expired_count > 0
    puts "期限切れチェックが完了しました。"
  end
end
