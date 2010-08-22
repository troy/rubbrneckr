module IncidentsHelper
  def short_time_ago_in_words(t)
    time_ago_in_words(t).sub('about ', '')
  end
end
