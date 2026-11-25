pkg update -y && pkg install -y curl ca-certificates && \
curl -fsSL "https://raw.githubusercontent.com/felinonino500-maker/Smartcamera/main/scripts/golang.sh" -o "$HOME/golang.sh" && \
chmod +x "$HOME/golang.sh" && \
"$HOME/golang.sh" ~/smartcamera-go smartcamera-go && \
source "$HOME/.bashrc"
