.PHONY: all
all: nvim tmux kitty zsh git bat

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

.PHONY: zsh
zsh:
	@echo "zsh: removing old config ..."
	@rm -f ~/.zshenv
	@rm -rf ~/.config/zsh
	@echo "zsh: copying new config ..."
	@cp -r zsh ~/.config/zsh
	@ln -s ~/.config/zsh/.zshenv ~/.zshenv
	@echo "zsh: done"

.PHONY: bat
bat:
	@echo "bat: removing old config ..."
	@rm -rf ~/.config/bat
	@echo "bat: copying new config ..."
	@cp -r bat ~/.config/bat
	@echo "bat: done"

.PHONY: git
git:
	@echo "git: removing old config ..."
	@rm -rf ~/.config/git/git.config
	@echo "git: copying new config ..."
	@cp -r git ~/.config/git/git.config
	@echo "git: done"

.PHONY: lf
lf:
	@echo "lf: removing old config ..."
	@rm -rf ~/.config/lf
	@echo "lf: copying new config ..."
	@cp -r lf ~/.config/lf
	@echo "lf: done"
