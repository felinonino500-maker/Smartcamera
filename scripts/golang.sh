#!/data/data/com.termux/files/usr/bin/bash
set -e

PROJECT_DIR="${1:-$HOME/go-firebase-app}"
MODULE_NAME="${2:-go-firebase-app}"

echo "=== [1/4] Update & Upgrade Paket Termux ==="
pkg update -y && pkg upgrade -y

echo "=== [2/4] Install Golang & Git ==="
pkg install -y golang git

echo "=== [3/4] Konfigurasi Environment Go ==="
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

if ! grep -q 'GOPATH=\$HOME/go' "$HOME/.bashrc" 2>/dev/null; then
  {
    echo ''
    echo '# Go Environment'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
  } >> "$HOME/.bashrc"
fi

go version

echo "=== [4/4] Setup Project & Install Modul Firebase Go v4 ==="
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

if [ ! -f "go.mod" ]; then
  go mod init "$MODULE_NAME"
fi

go get firebase.google.com/go/v4@latest
go get google.golang.org/api/option@latest
go mod tidy

if [ ! -f "main.go" ]; then
  cat << 'EOF' > main.go
package main

import (
	"context"
	"fmt"
	"log"

	firebase "firebase.google.com/go/v4"
	"google.golang.org/api/option"
)

func main() {
	ctx := context.Background()

	// Ganti "serviceAccountKey.json" dengan path file credential Firebase Anda
	opt := option.WithCredentialsFile("serviceAccountKey.json")
	app, err := firebase.NewApp(ctx, nil, opt)
	if err != nil {
		log.Fatalf("Gagal menginisialisasi Firebase App: %v", err)
	}

	fmt.Println("Firebase Admin SDK berhasil diinisialisasi:", app)
}
EOF
fi

echo ""
echo "Selesai! Direktori project ada di: $PROJECT_DIR"
echo "Jalankan 'source ~/.bashrc' atau buka ulang Termux agar PATH Go aktif."
