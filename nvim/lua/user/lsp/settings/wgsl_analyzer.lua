return {
    cmd = {"/home/alex/.cargo/bin/wgsl_analyzer"},
    settings = {
        ["wgsl-analyzer"] = {
            diagnostics = {
                typeErrors = true,
                nagaParsingErrors = true,
                nagaValidationErrors = true,
            }
        }
    }
}
