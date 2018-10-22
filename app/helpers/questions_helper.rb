module QuestionsHelper
  def sortable(column, title = nil, filter = nil, search = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "btn btn-outline-secondary current #{sort_direction} active" : "btn btn-outline-secondary"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {search_txt: search, filter: filter, sort: column, direction: direction}, {class: css_class, type: "button"}
  end
end
