package main

import (
	"log"

	"github.com/longan18/manage/backend/config"
	"github.com/longan18/manage/backend/routes"
)

func main() {
	// Load environment variables
	config.LoadEnv()

	// Connect to the database
	db, err := config.Connect()
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	// Run migrations
	if err := config.RunMigrations(db); err != nil {
		log.Fatalf("Migration error: %v", err)
	}

	// Set up and start the server
	router := routes.NewRouter()
	if err := routes.Start(router); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
