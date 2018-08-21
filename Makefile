REPO := blockloop/ghost
MAJOR ?= 2
MINOR ?= 0
PATCH ?= 2
FULL  := $(MAJOR).$(MINOR).$(PATCH)

build:
	docker build --build-arg VERSION=$(FULL) -t $(REPO):$(FULL) .
	docker tag $(REPO):$(FULL) $(REPO):latest
	docker tag $(REPO):$(FULL) $(REPO):$(MAJOR).$(MINOR)
	docker tag $(REPO):$(FULL) $(REPO):$(MAJOR)

push: build
	docker push $(REPO):latest
	docker push $(REPO):$(FULL)
	docker push $(REPO):$(MAJOR)
	docker push $(REPO):$(MAJOR).$(MINOR)
