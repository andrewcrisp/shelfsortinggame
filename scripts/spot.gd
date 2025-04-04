extends Node2D

var heldSortable = null

func hold_sortable(sortable):
	heldSortable = sortable
	
func remove_sortable():
	heldSortable = null
