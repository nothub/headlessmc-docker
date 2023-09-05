.PHONY: image
image:
	docker build -t headlessmc:dev .

.PHONY: clean
clean:
	-docker rmi -f headlessmc:dev 2>/dev/null
