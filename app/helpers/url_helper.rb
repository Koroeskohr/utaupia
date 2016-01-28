module UrlHelper  
  def url_with_protocol(url)
    /^http(s?):\/\//i.match(url) ? url : "http://#{url}"
  end
end