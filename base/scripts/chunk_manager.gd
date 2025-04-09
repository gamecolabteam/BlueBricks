## Manages [Chunk]s. Instantiating and freeing them as needed.
class_name ChunkManager extends Node2D


## Current center-most [Chunk]
var center_chunk: ChunkInfo
## The file names for each [Chunk].[br]
## From res://chunks
var chunk_files: PackedStringArray


func _physics_process(_delta: float) -> void:
	var c = center_chunk.chunk
	if c.global_position.x > 640.:
		# Unload right chunk and load left
		unload_chunk(center_chunk.neighbor_right)
		
		center_chunk = center_chunk.neighbor_left
		
		var cl = load_chunk(center_chunk.neighbor_left)
		cl.neighbor_right = center_chunk
		center_chunk.neighbor_left = cl
		
		var p = center_chunk.chunk.position
		p += Vector2(-640., 0.)
		cl.chunk.position = p
	elif c.global_position.x < 0.:
		# Unload left chunk and load right
		unload_chunk(center_chunk.neighbor_left)
		
		center_chunk = center_chunk.neighbor_right
		
		var cr = load_chunk(center_chunk.neighbor_right)
		cr.neighbor_left = center_chunk
		center_chunk.neighbor_right = cr
		
		var p = center_chunk.chunk.position
		p += Vector2(640., 0.)
		cr.chunk.position = p


func _ready() -> void:
	chunk_files = ResourceLoader.list_directory("res://chunks")
	
	var c = instantiate_chunk()
	var cl = instantiate_chunk()
	var cr = instantiate_chunk()
	
	add_child(c)
	add_child(cl)
	add_child(cr)
	
	cl.position = Vector2(-640., 0.)
	cr.position = Vector2(640., 0.)
	
	var ci = create_chunk_info(c)
	var cli = create_chunk_info(cl)
	var cri = create_chunk_info(cr)
	
	ci.neighbor_left = cli
	ci.neighbor_right = cri
	cli.neighbor_right = ci
	cri.neighbor_left = ci
	
	center_chunk = ci


## Creates a [ChunkInfo] for the given [param chunk].
func create_chunk_info(chunk: Chunk) -> ChunkInfo:
	var i = ChunkInfo.new()
	i.chunk = chunk
	i.scene_path = chunk.scene_file_path
	i.loaded = true
	return i


## Instantiates a [Chunk] with the given [param chunk_file_path].[br]
## If no file path is provided, instantiates a random chunk from [member chunk_files].
func instantiate_chunk(chunk_file_path: String = "") -> Chunk:
	if chunk_file_path.is_empty():
		var fi = randi_range(0, chunk_files.size() - 1)
		chunk_file_path = "res://chunks/%s" % chunk_files[fi]
	var s = load(chunk_file_path) as PackedScene
	var c = s.instantiate() as Chunk
	return c


## Loads the chunk from the given [param chunk_info].[br]
## Returns a new [ChunkInfo] with a random [Chunk] if [param chunk_info] is null.
func load_chunk(chunk_info: ChunkInfo) -> ChunkInfo:
	if not chunk_info: chunk_info = ChunkInfo.new()
	
	var c = instantiate_chunk(chunk_info.scene_path)
	chunk_info.chunk = c
	chunk_info.scene_path = c.scene_file_path
	add_child(c)
	chunk_info.loaded = true
	return chunk_info


## Unloads [param chunk_info] and frees [member ChunkInfo.chunk].
func unload_chunk(chunk_info: ChunkInfo):
	chunk_info.chunk.queue_free()
	chunk_info.loaded = false
