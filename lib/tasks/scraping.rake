require "#{Rails.root}/lib/scraping_work"
require "#{Rails.root}/lib/scraping_work_lancers"

namespace :scraping do
  desc "クラウドワークスの情報取得"
  task fetch_crowdworks: :environment do
    p "スクレイピングを開始しました。"
    ScrapingWork.sample_function
    url = "https://crowdworks.jp/public/jobs/1035766"
    doc = ScrapingWork.get_work_doc(url)
    p doc.at('//*[@id="job_offer_detail"]//h1/text()').text.strip
    work_hash = ScrapingWork.fetch_work(url, doc)
    Work.create!(work_hash)
  end

  desc "ランサーズの情報取得"
  task fetch_lancers: :environment do
    ScrapingWorkLancers.sample_function
    url = "https://www.lancers.jp/work/detail/2908104"
    doc = ScrapingWorkLancers.get_work_doc(url)
    p ScrapingWorkLancers.is_finish(doc)
  end
end
