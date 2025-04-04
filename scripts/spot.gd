extends Node2D

var heldSortable = null

func hold_sortable(sortable):
	heldSortable = sortable
	
func drop_sortable():
	heldSortable = null
