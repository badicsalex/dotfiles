return {
	settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
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
