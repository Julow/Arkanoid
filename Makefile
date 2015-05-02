# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/05/02 13:27:34 by jaguillo          #+#    #+#              #
#    Updated: 2015/05/02 14:38:44 by jaguillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := arkanoid

O_DIR := o
C_DIR := srcs

C_FLAGS := -Wall -Wextra -Werror -O2 -Iinclude
LD_FLAGS := -Wall -Wextra -Werror

C_FILES := $(shell find $(C_DIR) -type f -print)
O_FILES = $(C_FILES:$(C_DIR)/%.c=$(O_DIR)/%.o)

all: $(NAME)

$(NAME): libft/libft.a libglfw/src/libglfw3.a $(O_FILES)
	clang -o $@ $^ $(LD_FLAGS)

$(O_DIR)/%.o: $(C_DIR)/%.c $(O_DIR)
	clang $(C_FLAGS) -o $@ -c $<

libft/libft.a:
	@make -C libft

libglfw:
	@git submodule add https://github.com/glfw/glfw.git $@
	@git submodule update $@

libglfw/Makefile: libglfw
	@cd $< ; cmake .

libglfw/src/libglfw3.a: libglfw/Makefile
	@make -C libglfw

$(O_DIR):
	@mkdir -p $@ 2> /dev/null || true

clean:
	@rm -rf $(O_FILES)

fclean: clean
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
