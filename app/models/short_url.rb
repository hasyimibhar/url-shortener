class ShortUrl < ApplicationRecord
  validates :value, http_url: true

  def short_url(app_url)
    app_url + '/' + self.short
  end

  def self.generate(url)
    short_url = self.new
    short_url.value = url
    # TODO: don't hardcode the length of short url
    short_url.short = self.generate_random_string(6)
    
    return short_url
  end

  def self.generate_random_string(n)
    a = [('a'..'z')] # lowercase
    a << ('A'..'Z') # uppercase
    a << ('0'..'9') # digits
    a = a.map(&:to_a).flatten
    s = a.size-1

    (0...n).map { a[rand(s-1)] }.join
  end
end
