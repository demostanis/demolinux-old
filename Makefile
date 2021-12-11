default: build-packages buildnrun

build:
	@./scripts/build.sh

run:
	@./scripts/run.sh

buildnrun: build run

build-packages:
	@cd packages && \
	./build.sh && \
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
# %s^[^\.\n]+:$<ret>Hyge6o<esc>p6<space>hdjgh7K<a-j>
.PHONY:  build run buildnrun build-packages flash ssh

