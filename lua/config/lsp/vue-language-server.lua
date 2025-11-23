return {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "package.json", ".git" },
	settings = {
		emmet = {
			showExpandedAbbreviation = "never",
		},
	},
}
