# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bde-wits <bde-wits@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/02 06:57:40 by bde-wits          #+#    #+#              #
#    Updated: 2025/04/02 07:33:08 by bde-wits         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	$(COMPOSE) up -d

build:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

prune:
	docker system prune -a --volumes -f

re: clean all

.PHONY: all up build down clean prune re