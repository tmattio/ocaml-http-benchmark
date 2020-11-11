.PHONY: all
all:
	opam exec -- dune build --root .

.PHONY: deps
deps: ## Install development dependencies
	opam install --deps-only -y .

.PHONY: switch
switch: ## Create an opam switch and install development dependencies
	opam switch -y create . 4.10.0+multicore --deps-only --locked --packages=ocaml-variants.4.10.0+multicore,ocaml-secondary-compiler --repositories=multicore=git+https://github.com/ocamllabs/multicore-opam.git,default
	opam switch set 4.10.0+multicore

.PHONY: lock
lock: ## Generate a lock file
	opam lock -y .

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	opam exec -- dune build --root .

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	opam exec -- dune clean --root .

.PHONY: format
format: ## Format the codebase with ocamlformat
	opam exec -- dune build --root . --auto-promote @fmt

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	opam exec -- dune build --root . --watch
