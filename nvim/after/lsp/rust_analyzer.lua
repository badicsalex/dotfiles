return {
	settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                warningsAsHint = {"unexpected_cfgs"}
            },
            cargo = {
                allTargets = false,
                targetDir = true,
            },
        }
	},
}
