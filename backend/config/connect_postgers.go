package config

import (
	"fmt"
	"log"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"gorm.io/gorm"
	"github.com/longan18/manage/backend/component/gormc/dialets"
)

// Connect establishes a connection to the database
func Connect() (*gorm.DB, error) {
	dbConfig := DatabaseConfig()
	
	dsn := fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=%s",
		dbConfig["host"],
		dbConfig["user"],
		dbConfig["password"],
		dbConfig["dbname"],
		dbConfig["port"],
		dbConfig["sslmode"],
	)
	
	return dialets.PostgresDB(dsn)
} 

// RunMigrations runs database migrations
func RunMigrations(db *gorm.DB) error {
	sqlDB, err := db.DB()
	
	if err != nil {
		return fmt.Errorf("failed to get database instance: %w", err)
	}
	
	driver, err := postgres.WithInstance(sqlDB, &postgres.Config{})
	if err != nil {
		return fmt.Errorf("failed to create migration driver: %w", err)
	}

	migrationsPath := "file://./migrations/postgres"
	m, err := migrate.NewWithDatabaseInstance(migrationsPath, "postgres", driver)
	if err != nil {
		return fmt.Errorf("failed to initialize migrations: %w", err)
	}

	if err := m.Up(); err != nil && err != migrate.ErrNoChange {
		return fmt.Errorf("migration failed: %w", err)
	}

	log.Println("Migrations completed successfully!")
	
	return nil
} 