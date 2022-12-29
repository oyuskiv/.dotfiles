.PHONY: all
all: nvim tmux kitty

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

.PHONY: kitty
kitty:
	@echo "kitty: removing old config ..."
	@rm -rf ~/.config/kitty
	@echo "kitty: copying new config ..."
	@cp -r kitty ~/.config/kitty
	@echo "kitty: done"
