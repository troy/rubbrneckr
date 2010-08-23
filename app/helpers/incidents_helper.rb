module IncidentsHelper
  def short_time_ago_in_words(t)
    time_ago_in_words(t).sub('about ', '')
  end
  
  def formatted_location(location)
    location.is_a?(String) ? location : 'you'
  end
  
  def capitalize(s)
    s = s.capitalize.gsub(/\b\w/){$&.upcase}
    s = s.gsub(/ (Ne|Nw|Se|Sw) /, &lambda {" #{$1.upcase} "})
    s.gsub(' Of ', ' of ')  
  end
  
  def json_url
    incidents_path(params.merge(:format => 'json'))
  end
  
  def rss_url
    incidents_path(params.merge(:format => 'rss'))
  end
end
