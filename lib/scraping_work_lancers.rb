class ScrapingWorkLancers < ScrapingWork

  def self.sample_function
    p "ランサーズモジュールが正しく読み込まれています。"
  end

  def self.title(doc)
    doc.at('//section[contains(@class, "section-title-group")]/h1[contains(@class, "heading--lv1")]/text()').text.strip
  end

  def self.site_type
    :lancers
  end

  def self.reward(doc)
    description = doc.at('/html/head/meta[@name="description"]')[:content]
    reward_reg = /(?<=報酬：).*?(?=\))/
    return nil, nil unless description =~ reward_reg
    reward_range = description.match(reward_reg)[0].delete("円 ").split('〜')
    min = reward_range[0] =~ /\A[0-9]+\z/ ? reward_range[0] : nil
    max = reward_range[1] =~ /\A[0-9]+\z/ ? reward_range[1] : nil
    return min, max
  end

  def self.detail(doc)
    details = doc.search('//section[contains(@class, "section-work-detail-content")]/dl[contains(@class, "c-definitionList")]').map { |dl| dl.text.strip }
    details.join
  end

  def self.expired_at(doc)
    nil
  end

  def self.is_finish(doc)
    status = doc.at('//section[contains(@class, "section-title-group")]/div[contains(@class, "section-title-group__status")]')
    status.present? && status.text.include?("終了")
  end
end
