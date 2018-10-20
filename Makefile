dotword = $(word $2,$(subst ., ,$1))

VERSION := $(shell curl -SsL https://api.github.com/repos/TryGhost/ghost/releases/latest | jq -r '.tag_name')
MAJOR   := $(call dotword,$(VERSION),1)
MINOR   := $(call dotword,$(VERSION),2)
PATCH   := $(call dotword,$(VERSION),3)
REPO    := blockloop/ghost

.DEFAULT: build
build:
ifeq ($(VERSION),)
	$(error VERSION is missing. Maybe curl failed?)
endif
	@echo "Building $(VERSION)"
	@docker build --build-arg VERSION=$(VERSION) -t $(REPO):$(VERSION) .
	@docker tag $(REPO):$(VERSION) $(REPO):latest
	@docker tag $(REPO):$(VERSION) $(REPO):$(MAJOR).$(MINOR)
	@docker tag $(REPO):$(VERSION) $(REPO):$(MAJOR)

push: build
	@echo "Pushing $(VERSION)"
	@docker push $(REPO):latest
	@docker push $(REPO):$(VERSION)
	@docker push $(REPO):$(MAJOR)
	@docker push $(REPO):$(MAJOR).$(MINOR)
