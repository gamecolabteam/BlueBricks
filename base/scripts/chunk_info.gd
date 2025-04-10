## Info container for [Chunk].
## Used by [ChunkManager].
class_name ChunkInfo extends RefCounted


## The [Chunk].
var chunk: Chunk
## Is this [Chunk] loaded?
var loaded: bool
## Neightbor [Chunk] to the left
var neighbor_left: ChunkInfo
## Neightbor [Chunk] to the right
var neighbor_right: ChunkInfo
## [Chunk]'s scene file path [member PackedScene.scene_file_path]
var scene_path: String
