extends Node2D

var carriedSortable = null

func drop_sortable():
	carriedSortable = null
	
func hold_sortable(sortable):
	carriedSortable = sortable
