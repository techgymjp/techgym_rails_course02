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
    works_url = "https://www.lancers.jp/work/search?keyword=Rails&page=1"
    works_doc = ScrapingWorkLancers.get_work_doc(works_url)
    paths = works_doc.search('//div[contains(@class, "c-media-list")]//div[contains(@class, "c-media-list__item")]//a[contains(@class, "c-media__title")]').map {|a| a[:href] }
    paths = paths.slice(0...10)
    p paths
    paths.each do |path|
      if path =~ /\A\/work\/detail\/[0-9]+\z/
        url = "https://www.lancers.jp#{path}"
        sleep(5)
        doc = ScrapingWorkLancers.get_work_doc(url)
        p ScrapingWorkLancers.is_finish(doc)
        p ScrapingWorkLancers.detail(doc)
        work_hash = ScrapingWorkLancers.fetch_work(url, doc)
        if work = Work.find_by(url: url)
          work.update(work_hash)
        else
          Work.create(work_hash)
        end
      end
    end
  end
end
