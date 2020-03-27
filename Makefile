.DEFAULT_GOAL := help

install: ## Install npm dependencies for the api, admin, and frontend apps
	@echo "Installing Dotfiles"
	@bash bin/init.sh

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
