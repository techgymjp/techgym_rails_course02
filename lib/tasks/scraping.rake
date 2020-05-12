require "#{Rails.root}/lib/scraping_work"

namespace :scraping do
  desc "クラウドワークスの情報取得"
  task fetch_crowdworks: :environment do
    p "スクレイピングを開始しました。"
  end
end
