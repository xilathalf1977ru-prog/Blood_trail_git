extends Node

func load_res(folder_path: String)-> Array[Resource]:
	var res_list: Array[Resource] = []
	for i in DirAccess.open(folder_path).get_directories():
		res_list.append(load(folder_path.path_join(i) + "/" + i + ".tres"))
	return res_list
