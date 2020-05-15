module ScrapingWork

  def self.sample_function
    p "モジュールが正しく読み込まれています。"
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
    doc.at('//*[@id="job_offer_detail"]//h1/text()').text.strip
  end

  def self.site_type
    :crowdworks
  end

  def self.reward(doc)
    reward_range = doc.at('//section[contains(@class, "toplevel_information")]/table//div[@class="fixed_price_budget"]').text&.delete("円, ")&.split('〜')
    min = reward_range[0] =~ /\A[0-9]+\z/ ? reward_range[0] : nil
    max = reward_range[1] =~ /\A[0-9]+\z/ ? reward_range[1] : nil
    return min, max
  end

  def self.detail(doc)
    "detail"
  end

  def self.expired_at(doc)
    date_str = doc.at('//section[contains(@class, "toplevel_information")]//table/tbody/tr[4]/td').text
    date_str = "2000年1月1日" unless date_str.match(/\A\d{4}年\d{1,2}月\d{1,2}日\z/) 
    Date.strptime(date_str, "%Y年%m月%d日")
  end

  def self.is_finish(doc)
    false
  end
end
