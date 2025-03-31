package routes

import (
	"net/http"
	
	"github.com/gin-gonic/gin"
)

// NewRouter creates and configures a new Gin router
func NewRouter() *gin.Engine {
	r := gin.Default()
	
	// Health check endpoint
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})
	
	// Add more routes here
	
	return r
}

// Start starts the HTTP server
func Start(router *gin.Engine) error {
	return router.Run() // Default to :8080
} 