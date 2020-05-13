require "#{Rails.root}/lib/scraping_work"

namespace :scraping do
  desc "クラウドワークスの情報取得"
  task fetch_crowdworks: :environment do
    p "スクレイピングを開始しました。"
    ScrapingWork.sample_function
    url = "https://crowdworks.jp/public/jobs/1035766"
    doc = ScrapingWork.get_work_doc(url)
    p doc.at('//*[@id="job_offer_detail"]//h1/text()').text.strip
  end
end
