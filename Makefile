# Define color codes
YELLOW = \033[0;33m
NC = \033[0m # No Color

# Define echo function
define echo_status
	echo "${YELLOW}$(1)${NC}"
endef

.PHONY: all dev build lint preview clean init cert pnpm add env

all: dev

init: env cert pnpm install 
	
dev:
	@$(call echo_status,Running dev server...)
	@pnpm run dev

build:
	@$(call echo_status,Building...)
	@pnpm run build

test:
	@$(call echo_status,Running tests...)
	@pnpm run test

test-ci:
	@$(call echo_status,Running tests...)
	@pnpm run test:ci

lint:
	@$(call echo_status,Running typecheck...)
	@pnpm run typecheck
	@$(call echo_status,Running lint:fix...)
	@pnpm run lint:fix
	@$(call echo_status,Running lint...)
	@pnpm run lint

precommit: lint test-ci build

preview: build
	@$(call echo_status,Running preview...)
	@pnpm run preview

add:
	@$(call echo_status,Adding shadcn component: $(filter-out $@,$(MAKECMDGOALS)))
	@pnpm dlx shadcn@latest add $(filter-out $@,$(MAKECMDGOALS))

clean:
	rm -rf dist
	rm -rf node_modules

cert:
	@$(call echo_status,Checking for mkcert and localhost certificates...)
	@if ! command -v mkcert >/dev/null 2>&1; then \
		$(call echo_status,mkcert not found, installing...); \
		brew install mkcert nss; \
	else \
		$(call echo_status,mkcert is already installed.); \
	fi
	@$(call echo_status,Installing mkcert root CA...)
	@mkcert -install
	@if [ ! -f "./localhost.pem" ] || [ ! -f "./localhost-key.pem" ]; then \
		$(call echo_status,Generating localhost certificates...); \
		mkcert localhost; \
	else \
		$(call echo_status,Localhost certificates already exist.); \
	fi

env:
	@$(call echo_status,Checking for .env file...)
	@if [ ! -f ".env" ]; then \
		$(call echo_status,.env file not found, copying from .env.example...); \
		cp .env.example .env; \
		$(call echo_status,.env file created.); \
	else \
		$(call echo_status,.env file already exists.); \
	fi

pnpm:
	@$(call echo_status,Checking for pnpm...)
	@if ! command -v pnpm >/dev/null 2>&1; then \
		$(call echo_status,pnpm not found, installing...); \
		npm install -g pnpm; \
	else \
		$(call echo_status,pnpm is already installed.); \
	fi

install:
	@$(call echo_status,Installing dependencies...)
	@pnpm install

# Allow for passing arguments to the add command
%:
	@:
