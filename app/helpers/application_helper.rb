module ApplicationHelper

  def map_options_for_select
    Map.all.map{|m| [m.name,m.id]}
  end
end
