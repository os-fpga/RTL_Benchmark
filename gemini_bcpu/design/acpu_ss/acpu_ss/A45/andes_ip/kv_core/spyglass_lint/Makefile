
.PHONY: clean guard-%

all: guard-NDS_HOME guard-SPYGLASS_HOME
	spyglass -batch -parallel_run -project spyglass.prj -goal lint/lint_rtl -licqueue

clean:
	rm -rf spyglass

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
