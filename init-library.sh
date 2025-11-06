#!/bin/bash
# Usage: ./init-library.sh project-name [git@github.com:user/repo.git]

PROJECT_NAME=$1
REPO_URL=$2

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./init-library.sh project-name [git@github.com:user/repo.git]"
  exit 1
fi

echo "🚀 Creating PHP library project: $PROJECT_NAME"

mkdir -p $PROJECT_NAME/{src,tests}
cd $PROJECT_NAME || exit

# Git setup
git init -q
if [ -n "$REPO_URL" ]; then
  git remote add origin "$REPO_URL"
fi

# .gitignore
cat > .gitignore <<'EOF'
/vendor
/.idea
/.vscode
/.env
/.phpunit.result.cache
EOF

# Composer init
composer init --name="dranzd/${PROJECT_NAME}" \
  --description="${PROJECT_NAME} library" \
  --type=library \
  --license="MIT" \
  --autoload='{"psr-4":{"Dranzd\\'"${PROJECT_NAME^}"'\\":"src/"}}' \
  --require-dev="phpunit/phpunit:^9.5" \
  --stability=stable --no-interaction

composer install --no-interaction

# PHPUnit config
cat > phpunit.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<phpunit bootstrap="vendor/autoload.php" colors="true">
  <testsuites>
    <testsuite name="Tests">
      <directory>./tests</directory>
    </testsuite>
  </testsuites>
</phpunit>
EOF

# Dockerfile
cat > Dockerfile <<'EOF'
FROM php:8.2-cli

RUN apt-get update && apt-get install -y \
    git unzip zip libzip-dev && \
    docker-php-ext-install zip && \
    rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
WORKDIR /app
COPY . .
RUN composer install --no-interaction --prefer-dist
CMD ["./vendor/bin/phpunit", "--testdox"]
EOF

# docker-compose.yml
cat > docker-compose.yml <<'EOF'
version: '3.9'

services:
  php:
    build: .
    container_name: '${PROJECT_NAME}-php'
    volumes:
      - .:/app
    working_dir: /app
    command: bash
EOF

# utils script
cat > utils <<'EOF'
#!/usr/bin/env bash


# Common Event Sourcing - Docker Management Script
# Similar to Laravel Sail


COMPOSE="docker-compose"


# Determine if stdout is a terminal
if test -t 1; then
    # Determine if colors are supported
    ncolors=$(tput colors)
    if test -n "$ncolors" && test "$ncolors" -ge 8; then
        BOLD="$(tput bold)"
        YELLOW="$(tput setaf 3)"
        GREEN="$(tput setaf 2)"
        RED="$(tput setaf 1)"
        NC="$(tput sgr0)"
    fi
fi


# Function to display help
function display_help {
    echo "${GREEN}Common Event Sourcing - Docker Management${NC}"
    echo
    echo "${YELLOW}Usage:${NC}"
    echo "  ./utils COMMAND [options] [arguments]"
    echo
    echo "${YELLOW}Docker Commands:${NC}"
    echo "  ${GREEN}up${NC}              Start the Docker containers"
    echo "  ${GREEN}down${NC}            Stop the Docker containers"
    echo "  ${GREEN}restart${NC}         Restart the Docker containers"
    echo "  ${GREEN}build${NC}           Build the Docker containers"
    echo "  ${GREEN}rebuild${NC}         Rebuild the Docker containers from scratch"
    echo "  ${GREEN}ps${NC}              Show container status"
    echo "  ${GREEN}logs${NC}            Show container logs"
    echo
    echo "${YELLOW}Shell Commands:${NC}"
    echo "  ${GREEN}shell${NC}           Open a shell in the PHP container"
    echo "  ${GREEN}bash${NC}            Alias for shell"
    echo "  ${GREEN}root-shell${NC}      Open a root shell in the PHP container"
    echo
    echo "${YELLOW}Composer Commands:${NC}"
    echo "  ${GREEN}composer${NC}        Run Composer commands"
    echo "  ${GREEN}install${NC}         Run composer install"
    echo "  ${GREEN}update${NC}          Run composer update"
    echo "  ${GREEN}dump-autoload${NC}   Run composer dump-autoload"
    echo
    echo "${YELLOW}Testing Commands:${NC}"
    echo "  ${GREEN}test${NC}            Run PHPUnit tests"
    echo "  ${GREEN}phpstan${NC}         Run PHPStan static analysis"
    echo "  ${GREEN}cs-check${NC}        Check code style with PHPCS"
    echo "  ${GREEN}cs-fix${NC}          Fix code style with PHPCBF"
    echo "  ${GREEN}quality${NC}         Run all quality checks (test, phpstan, cs-check)"
    echo
    echo "${YELLOW}Utility Commands:${NC}"
    echo "  ${GREEN}php${NC}             Run PHP commands"
    echo "  ${GREEN}exec${NC}            Execute a command in the container"
    echo
    exit 0
}


# Proxy PHP commands to the container
if [ "$1" == "php" ]; then
    shift 1
    $COMPOSE exec php php "$@"


# Proxy Composer commands to the container
elif [ "$1" == "composer" ]; then
    shift 1
    $COMPOSE exec php composer "$@"


# Composer shortcuts
elif [ "$1" == "install" ]; then
    $COMPOSE exec -T php composer install


elif [ "$1" == "update" ]; then
    $COMPOSE exec -T php composer update


elif [ "$1" == "dump-autoload" ]; then
    $COMPOSE exec -T php composer dump-autoload


# Testing commands
elif [ "$1" == "test" ]; then
    shift 1
    $COMPOSE exec -T php composer test "$@"


elif [ "$1" == "phpstan" ]; then
    $COMPOSE exec -T php composer phpstan


elif [ "$1" == "cs-check" ]; then
    $COMPOSE exec -T php composer cs-check


elif [ "$1" == "cs-fix" ]; then
    $COMPOSE exec -T php composer cs-fix


elif [ "$1" == "quality" ]; then
    echo "${YELLOW}Running quality checks...${NC}"
    echo
    echo "${GREEN}1. Running tests...${NC}"
    $COMPOSE exec php composer test
    echo
    echo "${GREEN}2. Running PHPStan...${NC}"
    $COMPOSE exec php composer phpstan
    echo
    echo "${GREEN}3. Checking code style...${NC}"
    $COMPOSE exec php composer cs-check
    echo
    echo "${GREEN}Quality checks complete!${NC}"


# Docker management commands
elif [ "$1" == "up" ]; then
    shift 1
    $COMPOSE up -d "$@"
    echo "${GREEN}Containers started successfully!${NC}"


elif [ "$1" == "down" ]; then
    shift 1
    $COMPOSE down "$@"
    echo "${GREEN}Containers stopped successfully!${NC}"


elif [ "$1" == "restart" ]; then
    $COMPOSE restart
    echo "${GREEN}Containers restarted successfully!${NC}"


elif [ "$1" == "build" ]; then
    $COMPOSE build
    echo "${GREEN}Containers built successfully!${NC}"


elif [ "$1" == "rebuild" ]; then
    $COMPOSE down
    $COMPOSE build --no-cache
    $COMPOSE up -d
    echo "${GREEN}Containers rebuilt successfully!${NC}"


elif [ "$1" == "ps" ]; then
    $COMPOSE ps


elif [ "$1" == "logs" ]; then
    shift 1
    $COMPOSE logs -f "$@"


# Shell commands
elif [ "$1" == "shell" ] || [ "$1" == "bash" ]; then
    $COMPOSE exec php bash


elif [ "$1" == "root-shell" ]; then
    $COMPOSE exec -u root php bash


# Execute arbitrary commands
elif [ "$1" == "exec" ]; then
    shift 1
    $COMPOSE exec -T php "$@"


# Display help
else
    display_help
fi
EOF

chmod +x utils

# First commit
git add .
git commit -m "chore: initial setup for ${PROJECT_NAME} library" >/dev/null

if [ -n "$REPO_URL" ]; then
  git branch -M main
  git push -u origin main
fi

echo "✅ Library project '$PROJECT_NAME' setup complete."

