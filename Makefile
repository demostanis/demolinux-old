default: build-packages buildnrun

build:
	@./scripts/build.sh

run:
	@./scripts/run.sh

buildnrun: build run

build-packages:
	@cd packages && \
	./build.sh $(P) && \
	./repo.sh

# make DEVICE=/dev/sdx flash
flash:
	@./scripts/flash.sh

# to remotely connect
# to the QEMU VM
ssh:
	@sed -i '/\[localhost\]:60022/d' ~/.ssh/known_hosts && \
	ssh demostanis@localhost -p60022

# oh my god i'm so proud i generated this using kakoune
# gjf l<a-l>d%s^[^@\.\n]+:<ret>Hygj7o<esc>p<,>j8K<a-j>
.PHONY: default build run buildnrun build-packages flash ssh
