return {
	settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
                command = "clippy"
            },
            check = {
                allTargets = false
            },
        }
	},
    cmd = {"rustup", "run", "stable", "rust-analyzer"},
}
