var rankingGrid = obterRanking()
Nome = rankingGrid[# 0,self.ranking-1]
var Parts = string_split(Nome,"_")
Nome = string_capitalize(Parts[0])
if (Parts[0] != array_last(Parts)){
	var len = array_length(Parts)
	for(var i = 1; i<len;i++){
		Parts[i] = string_capitalize(Parts[i])
		Nome = string_join(" ",Nome,Parts[i])
	}
}

Pontos = rankingGrid[# 1, self.ranking-1]
ds_grid_destroy(rankingGrid)
