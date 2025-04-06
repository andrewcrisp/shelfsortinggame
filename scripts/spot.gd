extends Node2D

signal item_held(spot)
signal item_dropped(spot)

var heldSortable = null

func hold_sortable(sortable):
	heldSortable = sortable
	
func remove_sortable():
	heldSortable = null
