module QuestionsHelper
	def sortable(column, title = nil, filter = nil, search = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "btn btn-secondary-outline current #{sort_direction} active" : "btn btn-secondary-outline"
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:search_txt => search, :filter => filter, :sort => column, :direction => direction}, {:class => css_class, :type => "button"}
	end
end
