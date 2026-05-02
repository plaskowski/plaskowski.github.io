IMAGE   := plaskowski-github-io
PORT    := 4000
CONTAINER := jekyll-preview

.PHONY: build serve stop open

build:
	docker build -t $(IMAGE) .

serve: stop
	docker run --rm -d \
	  --name $(CONTAINER) \
	  -v "$(PWD):/site" \
	  -p $(PORT):4000 \
	  $(IMAGE)
	@echo "Serving at http://localhost:$(PORT)"

stop:
	docker stop $(CONTAINER) 2>/dev/null || true

open:
	open http://localhost:$(PORT)
