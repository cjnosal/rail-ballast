build-env:
	docker build -f Dockerfile.env -t rails-dev .

launch:
	docker run -it -v ./my-project:/home/ubuntu/my-project -p 3000:3000 --name rails-dev rails-dev bash --login

setup-runtime:
	docker exec -it rails-dev bash --login ./ruby.sh
	docker exec -it rails-dev bash --login ./node.sh

setup-project:
	docker exec -it rails-dev bash --login ./project.sh

serve:
	docker exec -it rails-dev bash --login ./my-project/bin/dev

debug:
	docker exec -it rails-dev bash --login