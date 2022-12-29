.PHONY: all
all: nvim tmux

.PHONY: nvim
nvim:
	@echo "nvim: removing old config ..."
	@rm -rf ~/.config/nvim
	@echo "nvim: copying new config ..."
	@cp -r nvim ~/.config/nvim
	@echo "nvim: done"

.PHONY: tmux
tmux:
	@echo "tmux: removing old config ..."
	@rm -rf ~/.config/tmux
	@echo "tmux: copying new config ..."
	@cp -r tmux ~/.config/tmux
	@echo "tmux: done"
