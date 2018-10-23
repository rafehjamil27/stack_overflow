module QuestionsHelper
  def sortable(column, title = nil, filter = nil, search = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "btn btn-outline-secondary current #{sort_direction} active" : "btn btn-outline-secondary"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { search_txt: search, filter: filter, sort: column, direction: direction }, { class: css_class, type: "button" }
  end

  def filters(title = nil, filter_type = nil, extra_args)
    css_class = filter_type == filtered ? "btn btn-outling-secondary active" : "btn btn-outline-secondary"
    link_to title, { sort: extra_args[:sort], direction: extra_args[:direction], filter: filter_type }, { class: css_class, type: "button" }
  end
end
