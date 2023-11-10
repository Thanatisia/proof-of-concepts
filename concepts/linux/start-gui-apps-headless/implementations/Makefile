# Makefile

## Ingredients/Variables
src_dir = "."
src_file = "start_xvfb.sh"
log_dir = "logs"
log_out = "out.log"
log_err = "error.log"

ENV = DISPLAY=":6"
.DEFAULT_RULES := help
.PHONY := help kill start

## Rules/Targets
help:
	## Display help menu
	@echo -e "Display Help"
	@echo -e "kill : Kill all dependencies"
	@echo -e "start : Begin running script"

kill:
	@pkill x11vnc
	@pkill websockify
	@pkill alacritty
	@pkill Xvfb

start:
	@${ENV} ./${src_dir}/${src_file} > ${log_dir}/${log_out} 2> ${log_dir}/${log_err} && \
		echo -e "[+] Success" || \
		echo -e "[X] Error"

