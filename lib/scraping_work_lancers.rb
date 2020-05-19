module ScrapingWorkLancers

  def self.sample_function
    p "ランサーズモジュールが正しく読み込まれています。"
  end

  def self.get_work_doc(url)
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
    f = OpenURI.open_uri(url, { read_timeout: 300, "User-Agent" => user_agent })
    file = f.read.gsub(/<br>/, "\n")
    Nokogiri::HTML.parse(file, nil, "utf-8")
  end

  def self.fetch_work(url, doc)
    reward_min, reward_max = reward(doc)
    return {
      title: title(doc),
      url: url,
      site_type: site_type,
      reward_max: reward_max,
      reward_min: reward_min,
      detail: detail(doc),
      expired_at: expired_at(doc),
      is_finish: is_finish(doc)
    }
  end

  def self.title(doc)
    doc.at('//section[contains(@class, "section-title-group")]/h1[contains(@class, "heading--lv1")]/text()').text.strip
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

  def self.is_finish(doc)
    false
  end
end
