package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

// LoadEnv loads environment variables from .env file
func LoadEnv() {
	if err := godotenv.Load(); err != nil {
		log.Printf("Warning: .env file not found or error loading. Using default environment variables.")
	}
}

// GetEnv gets an environment variable or returns a default value
func GetEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

// DatabaseConfig returns database configuration from environment variables
func DatabaseConfig() map[string]string {
	return map[string]string{
		"host":     GetEnv("DB_HOST", "postgres"),
		"user":     GetEnv("DB_USER", "postgres"),
		"password": GetEnv("DB_PASSWORD", "postgres"),
		"dbname":   GetEnv("DB_NAME", "manage"),
		"port":     GetEnv("DB_PORT", "5432"),
		"sslmode":  GetEnv("DB_SSL_MODE", "disable"),
	}
} 