alias ltspice='wine ~/.wine/drive_c/Program\ Files/LTC/LTspiceXVII/XVIIx64.exe'

alias mclauncher='flatpak run org.prismlauncher.PrismLauncher'

alias watchgpu='watch -n 1 nvidia-smi'

alias ollama='docker exec -it ollama /bin/ollama'

alias pyvenv='source ./.venv/bin/activate'

alias cls='clear'

alias files='xdg-open'

alias run-ollama='docker run -d --runtime=nvidia --gpus all \
  -p 11434:11434 \
  -v /mnt/shared/ollama-docker/models:/root/.ollama/models \
  --restart always \
  -e OLLAMA_HOST=0.0.0.0 \
  -e LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64 \
  -e NVIDIA_DRIVER_CAPABILITIES=compute,utility \
  -e NVIDIA_VISIBLE_DEVICES=all \
  --name ollama \
  ollama/ollama:latest serve'

alias vi='/usr/bin/nvim.appimage'
alias vim='/usr/bin/nvim.appimage'
alias nvim='/usr/bin/nvim.appimage'
alias code='function _code() { real_path=$(readlink -f "$1" 2>/dev/null || echo "$PWD"); /snap/bin/code "$real_path"; }; _code'
alias nvimc='nvim $(realpath ~/.config/nvim)'
