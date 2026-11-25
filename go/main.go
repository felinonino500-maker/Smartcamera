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
