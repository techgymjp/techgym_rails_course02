class ScrapingWorkLancers < ScrapingWork

  def self.sample_function
    p "ランサーズモジュールが正しく読み込まれています。"
  end

  def self.title(doc)
    doc.at('//h1[contains(@class, "c-heading--lv1")]').text.strip
  end

  def self.site_type
    :lancers
  end

  def self.reward(doc)
    reward_text = doc.at('.detail-order__content__price')&.text
    reward_text ||= ""
    numbers = reward_text.scan(/\d{1,3}(?:,\d{3})*(?:\.\d+)?/).map { |num| num.tr(',', '').to_i }
    min = numbers[0] if numbers.size >= 1
    max = numbers[1] if numbers.size >= 2
    return min, max
  end

  def self.detail(doc)
    details = doc.search('//dl[contains(@class, "c-definition-list")]/dd[contains(@class, "c-definition-list__description")]').map { |dd| dd.text.strip }
    details.join
  end

  def self.expired_at(doc)
    nil
  end

  def self.is_finish(doc)
    status = doc.at('//div[contains(@class, "p-work-detail-client__is-completed")]')
    status.present? && status.text.include?("終了")
  end
end
