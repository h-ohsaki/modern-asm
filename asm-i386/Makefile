tag = $(shell head -1 Dockerfile | sed 's/^\# *//')
name = $(shell basename `pwd` .sh)

build:
	docker build --tag $(tag) .

test:	build
	docker run -it --rm $(run_args) $(tag)

push:	build
	docker push $(tag)

run:	build
	./$(name).sh -f start

start:	build
	./$(name).sh start

stop:	build
	./$(name).sh stop

shell:	build
	./$(name).sh shell
