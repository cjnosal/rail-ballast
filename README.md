# Rails stack

Bootstrap a Ruby-on-Rails project with Typescript, React.js and Tailwind frontend.

## Setup

### Prerequisites
1. make
2. docker

### Build the dev container
`make build-env`

### Initialize the dev environment
1. `make launch` starts the `rails-dev` container with a volume binding `./my-project`
2. `make setup-runtime` installs ruby and node.js

### Scaffold a project
`make setup-project` creates a new rails project and adds a stub controller with corresponding react component.

## Launch
`make serve` launches the rails server inside the `rails-dev` container.  
Connect to `http://localhost:3000`

## Develop
Edit the `./my-project` source in your favorite IDE.  
Run `make debug` for an interactive shell inside the `rails-dev` container.
