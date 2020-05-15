module ScrapingWorkLancers
  include ScrapingWork

  def self.sample_function
    p "ランサーズモジュールが正しく読み込まれています。"
  end

  def self.title(doc)
    doc.at('//*[@id="job_offer_detail"]//h1/text()').text.strip
  end

  def self.site_type
    :lancers
  end

  def self.reward(doc)
    return "0", "0"
  end

  def self.detail(doc)
    "detail"
  end

  def self.expired_at(doc)
    nil
  end

  def self.is_finish
    false
  end
end
