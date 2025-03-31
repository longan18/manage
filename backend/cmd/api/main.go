package main

import (
	"fmt"
	"net/http"
	"github.com/gin-gonic/gin"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	gormPostgres "gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func main() {
	r := gin.Default()
    
    r.GET("/ping", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
        "message": "pong",
        })
    })

    dsn := "host=postgres user=postgres password=postgres dbname=manage port=5432 sslmode=disable"
    db, err := gorm.Open(gormPostgres.Open(dsn), &gorm.Config{})
    if err != nil {
        panic("Failed to connect to database: " + err.Error())
    }
    
    // Lấy database instance từ gorm
    sqlDB, err := db.DB()
    if err != nil {
        panic("Failed to get database: " + err.Error())
    }

    driver, err := postgres.WithInstance(sqlDB, &postgres.Config{})
    if err != nil {
        panic("Failed to create migration driver: " + err.Error())
    }

    migrationsPath := "file://./migrations/postgres"
    m, err := migrate.NewWithDatabaseInstance(migrationsPath, "postgres", driver)
    if err != nil {
        panic("Failed to initialize migrations: " + err.Error())
    }

    m.Up() 
    if err != nil && err != migrate.ErrNoChange {
        panic("Migration failed: " + err.Error())
    }
    fmt.Println("Migrations completed successfully!")

    r.Run() 
}