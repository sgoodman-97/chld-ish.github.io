all: build

RUBY_VER = 3.2.2
RUBY_BASE_VER = 3.2.0
RUBY_BINDIR = /usr/local/Cellar/ruby/$(RUBY_VER)/bin
GEM = $(RUBY_BINDIR)/gem
BUNDLER = $(RUBY_BINDIR)/bundle

BUNDLER_CACHE = vendor
#HAML_PATH = $(BUNDLER_CACHE)/ruby/3.2.0/bin/haml
#HAML = $(BUNDLER) exec haml
#HAML_FLAGS = -I lib -r haml_init

#ROOT_PATH = docs
#PAGES_PATH = pages
#PAGE_SOURCES = $(shell find $(PAGES_PATH) -name *.html.haml)
#PAGES = $(patsubst $(PAGES_PATH)/%.haml, $(ROOT_PATH)/%, $(PAGE_SOURCES))

#MIDDLEMAN_PATH = $(BUNDLER_CACHE)/ruby/3.2.0/bin/middleman
MIDDLEMAN = /usr/local/lib/ruby/gems/$(RUBY_BASE_VER)/bin/middleman

$(BUNDLER) $(GEM):
	@echo 'Ruby $(RUBY_VER) is not installed. Please install it by running `brew install ruby`'
	@false

$(MIDDLEMAN): $(GEM)
	$(GEM) install middleman

.PHONY: middleman-init
middleman-init:
	env "PATH=/usr/local/opt/ruby/bin:$$PATH" $(MIDDLEMAN) init

.PHONY: bundle
bundle: $(BUNDLER)
	$(BUNDLER)

.PHONY: build
build:
	env "PATH=/usr/local/opt/ruby/bin:$$PATH" $(MIDDLEMAN) build --verbose

#haml-help::
#	$(HAML) help
#	$(HAML) help render
#	$(HAML) render $(HAML_FLAGS) /dev/null
#
#.PHONY: pages
#pages: $(PAGES)
#
#$(ROOT_PATH)/%.html: $(PAGES_PATH)/%.html.haml partials/layout.html.haml $(HAML_PATH)
#	rm -f $@
#	$(HAML) render $(HAML_FLAGS) $< > $@ || (rm -f $@; false)
#	chmod 444 $@

#.PHONY: clean
#clean::
#	rm -f $(PAGES)

preview serve:
	env "PATH=/usr/local/opt/ruby/bin:$$PATH" $(MIDDLEMAN) serve

validate valid lint:: build
	./validate.command
