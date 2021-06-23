# Build configuration
# -------------------

APP_NAME = `node -p "require('./package.json').name"`
GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
GIT_REVISION = `git rev-parse HEAD`

# Introspection targets
# ---------------------

.PHONY: help
help: header targets

.PHONY: header
header:
	@echo "\033[34mEnvironment\033[0m"
	@echo "\033[34m---------------------------------------------------------------\033[0m"
	@printf "\033[33m%-23s\033[0m" "APP_NAME"
	@printf "\033[35m%s\033[0m" $(APP_NAME)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "GIT_BRANCH"
	@printf "\033[35m%s\033[0m" $(GIT_BRANCH)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "GIT_REVISION"
	@printf "\033[35m%s\033[0m" $(GIT_REVISION)
	@echo "\n"

.PHONY: targets
targets:
	@echo "\033[34mTargets\033[0m"
	@echo "\033[34m---------------------------------------------------------------\033[0m"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# Development targets
# -------------------

copy-assets:
	cp -R public dist

.PHONY: clean
clean: ## Remove build artifacts
	rm -rf dist

.PHONY: build
build: clean copy-assets ## Make a production build
	elm make src/Main.elm --output=dist/js/elm.js --optimize

.PHONY: deps
deps: ## Install all dependencies
	yarn install

.PHONY: format
format: format-css format-elm ## Format everything

.PHONY: format-css
format-css: ## Format stylesheets
	yarn prettier --write 'public/css/*.{css,scss}'

.PHONY: format-elm
format-elm: ## Format elm
	elm-format src/ --yes

.PHONY: run
run: copy-assets ## Run web app
	node_modules/.bin/elm-live src/Main.elm --port=4000 --dir=dist -- --debug --output=dist/js/elm.js
