dotword = $(word $2,$(subst ., ,$1))

VERSION      := $(shell curl -SLs https://api.github.com/repos/TryGhost/ghost/releases/latest | jq -r '.tag_name')
MAJOR        := $(call dotword,$(VERSION),1)
MINOR        := $(call dotword,$(VERSION),2)
PATCH        := $(call dotword,$(VERSION),3)
REPO         := docker.io/blockloop/ghost
OCI_RUNTIME  := $(shell which podman 2>/dev/null || which docker)
NODE_VERSION := $(shell curl -SLs https://raw.githubusercontent.com/TryGhost/Ghost/$(VERSION)/package.json | jq -r '.engines.node' | awk '{ print $$NF }' | tr -d '^')

.DEFAULT: build
build:
ifeq ($(VERSION),)
	$(error VERSION is missing. Maybe curl failed?)
else ifeq ($(NODE_VERSION),)
	$(error NODE_VERSION is missing. Maybe curl failed?)
endif
	@echo "Building $(VERSION) with $(OCI_RUNTIME)"
	$(OCI_RUNTIME) build \
		--build-arg VERSION=$(VERSION) \
		--build-arg NODE_VERSION=$(NODE_VERSION) \
		-t $(REPO):$(VERSION) \
		-t $(REPO):$(MAJOR) \
		-t $(REPO):$(MAJOR).$(MINOR) \
		.
	$(OCI_RUNTIME) tag $(REPO):$(VERSION) $(REPO):latest
	$(OCI_RUNTIME) tag $(REPO):$(VERSION) $(REPO):$(MAJOR).$(MINOR)
	$(OCI_RUNTIME) tag $(REPO):$(VERSION) $(REPO):$(MAJOR)

push: build
	@echo "Pushing $(VERSION)"
	$(OCI_RUNTIME) push $(REPO):latest
	$(OCI_RUNTIME) push $(REPO):$(VERSION)
	$(OCI_RUNTIME) push $(REPO):$(MAJOR)
	$(OCI_RUNTIME) push $(REPO):$(MAJOR).$(MINOR)
