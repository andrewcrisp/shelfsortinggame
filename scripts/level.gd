extends Node2D

var carriedItem = null

func drop_item():
	carriedItem = null
	
func hold_item(item):
	carriedItem = item
