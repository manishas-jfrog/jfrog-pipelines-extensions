COMMON_LIB := lib/common.sh
TARGET_DIRS = $(sort $(dir $(wildcard steps/declarativesystems/*/)))

scripts: test
	$(foreach TARGET_DIR,$(TARGET_DIRS),$(call concat_file,$(TARGET_DIR)))


define concat_file
	echo "# =====[DO NOT EDIT THIS FILE]=====" > $(1)onExecute.sh
	cat $(COMMON_LIB) >> $(1)onExecute.sh
	cat $(1)src/onExecute.sh >> $(1)onExecute.sh

endef

clean:
	rm -f steps/declarativesystems/*/onExecute.sh

test:
	echo "=== bash syntax ==="
	bash -n lib/common.sh
	find . -iname '*.sh' -print0 | xargs -0L1 bash -n

	echo "=== yaml syntax ==="
	./res/validate_yaml.py
