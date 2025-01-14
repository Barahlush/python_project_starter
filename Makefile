TARGET_NAME := "perfect_python_project"
PYTHON_VERSION := $(shell python --version | sed -r -e 's/Python //' -e 's/\.[0-9]+$$//')

test:
	@echo Target: /tmp/$(TARGET_NAME)
	@if [ -d /tmp/$(TARGET_NAME) ]; then \
		rm -rf /tmp/$(TARGET_NAME); \
	fi

	@echo -n "default_context:\n\
    author: \"Fulano de Tal\"\n\
    email: \"fulano@email.com\"\n\
    project_slug: \"$(TARGET_NAME)\"\n\
    python_version: \"$(PYTHON_VERSION)\"\n\
    line_length: 100\n\
	" > /tmp/$(TARGET_NAME).yml

	cookiecutter --no-input --config-file /tmp/$(TARGET_NAME).yml -o /tmp .

	cd /tmp/$(TARGET_NAME); \
	poetry run make test; \
	poetry run make lint
