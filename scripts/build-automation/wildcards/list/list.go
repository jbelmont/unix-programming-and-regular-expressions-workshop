package list

func showMeList() map[string]string {
	return map[string]string{
		"$?": "$?",
		"~":  "list home directory",
		"$*": "The stem with which an implicit rule matches",
	}
}
