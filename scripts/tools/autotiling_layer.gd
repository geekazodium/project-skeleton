extends TileMapLayer
class_name AutotilingLayer

@export var tile_data_source: TileMapLayer;

@export var match_tile_type: int = 1;

const TILE_TYPE_DATA_LAYER: String = "tile_type";

var last_rect: Rect2i = Rect2i(0,0,0,0);

var packed_tileset_mapping: PackedByteArray = [255, 20, 18, 19, 2, 16, 10, 1, 4, 12, 17, 0, 3, 8, 9, 11];

func tileset_mapping_lookup_coords(k: int) -> Vector2i:
	var index: int = packed_tileset_mapping[k];
	return Vector2i(index & 0x7, (index >> 3) & 0x3);

func _ready() -> void:
	self.update_autotile();

func update_autotile() -> void:
	var rect = self.tile_data_source.get_used_rect();
	rect.grow_side(SIDE_LEFT, 1);
	rect.grow_side(SIDE_TOP, 1);
	
	var last_rect_min: Vector2 = self.last_rect.position;
	var last_rect_max: Vector2 = self.last_rect.position + self.last_rect.size;
	
	self.last_rect = rect;
	
	rect = rect.expand(last_rect_min);
	rect = rect.expand(last_rect_max);
	
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			var cell: Vector2i = Vector2i(x,y);
			#return;
			var tile_1_data = self.tile_data_source.get_cell_tile_data(cell);
			var tile_2_data = self.tile_data_source.get_cell_tile_data(cell + Vector2i.RIGHT);
			var tile_4_data = self.tile_data_source.get_cell_tile_data(cell + Vector2i.ONE);
			var tile_8_data = self.tile_data_source.get_cell_tile_data(cell + Vector2i.DOWN);
			
			var tile_1: int = -1;
			var tile_2: int = -1;
			var tile_4: int = -1;
			var tile_8: int = -1;
			
			if tile_1_data != null:
				tile_1 = tile_1_data.get_custom_data(TILE_TYPE_DATA_LAYER);
			if tile_2_data != null:
				tile_2 = tile_2_data.get_custom_data(TILE_TYPE_DATA_LAYER);
			if tile_4_data != null:
				tile_4 = tile_4_data.get_custom_data(TILE_TYPE_DATA_LAYER);
			if tile_8_data != null:
				tile_8 = tile_8_data.get_custom_data(TILE_TYPE_DATA_LAYER);
			
			var data_index = 0;
			if tile_1 == self.match_tile_type:
				data_index |= 1;
			if tile_2 == self.match_tile_type:
				data_index |= 2;
			if tile_4 == self.match_tile_type:
				data_index |= 4;
			if tile_8 == self.match_tile_type:
				data_index |= 8;
			
			if data_index == 0:
				self.set_cell(cell);
				continue;
			var atlas_pos: Vector2i = self.tileset_mapping_lookup_coords(data_index);
			self.set_cell(cell,0,atlas_pos);
