PORT := 4000
JEKYLL := /opt/homebrew/lib/ruby/gems/3.4.0/bin/jekyll

.PHONY: serve stop open

serve:
	$(JEKYLL) serve --port $(PORT) --watch --livereload

open:
	open http://localhost:$(PORT)
