# One documented way to run and submit this project.
# `make` with no arguments lists the targets.

TAG ?= lab-05

.DEFAULT_GOAL := help
.PHONY: help dev web test submit

help:  ## show this help
	@grep -hE '^[a-z-]+:.*?## ' $(MAKEFILE_LIST) \
	 | awk -F':.*?## ' '{printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

dev:   ## run the API on :8000
	uvicorn main:app --reload --host 0.0.0.0 --port 8000

web:   ## serve the frontend on :8080 (lab 6)
	python -m http.server 8080 --directory web

test:  ## run the tests
	pytest -q

# Package a tagged snapshot for Canvas.
#
# Produces a git *bundle*, not a zip: one file holding the repository AND its
# history up to the tag, so your instructor can `git clone` it and read your
# commits. A zip would carry only the files.
#
# Only committed work is included — that is the point. Your .env and your
# database are gitignored, so they cannot leak into a submission by accident,
# and work you did after the tag (next week's lab) is not in it either.
#
# Why the temporary worktree: `git clone` needs a HEAD to check out. A bundle
# built from a tag alone has no HEAD, and clones into an empty directory that
# looks like you submitted nothing. Checking the tag out in a throwaway worktree
# puts HEAD at the right commit without touching your working tree.
submit:  ## package a tagged snapshot for Canvas (make submit TAG=lab-05)
	@git rev-parse -q --verify "refs/tags/$(TAG)" >/dev/null \
	  || { echo "No tag '$(TAG)'. Create it first:  git tag $(TAG)"; exit 1; }
	@test -z "$$(git status --porcelain)" \
	  || echo "⚠️  Uncommitted changes are NOT in the bundle. Commit, move the tag, re-run."
	@rm -rf .submit-wt "$(TAG).bundle"
	@git worktree add --detach .submit-wt $(TAG) >/dev/null 2>&1
	@git -C .submit-wt bundle create "$(CURDIR)/$(TAG).bundle" HEAD >/dev/null 2>&1
	@git worktree remove --force .submit-wt >/dev/null 2>&1
	@echo
	@echo "✅ Wrote $(TAG).bundle ($$(du -h $(TAG).bundle | cut -f1)), $$(git rev-list --count $(TAG)) commits"
	@echo "   Upload it to Canvas with your executive summary."
	@echo "   Right-click it in the VS Code explorer → Download."
	@echo
	@echo "   Verify it before you submit:"
	@echo "     git clone $(TAG).bundle /tmp/check && ls /tmp/check"
