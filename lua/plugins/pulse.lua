return {
    "linguini1/pulse.nvim",
    version = "*", -- Latest stable release
    config = function() 
      require("pulse").setup()
      require("pulse").add("exercise", {
	interval=30,
	message="Take a fucking break",
	enabled=true
      })
    end -- Call setup to get the basic config
}
