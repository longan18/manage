package routes

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/longan18/manage/backend/module/auth/transport"
	"gorm.io/gorm"
)

func NewRouter(db *gorm.DB) *gin.Engine {
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})
	
	v1 := r.Group("v1") 
	{
		// POST /v1/auth/sign-up
		v1.POST("auth/sign-up", transport.SignUp(db))
	}
	
	return r
}

func Start(router *gin.Engine) error {
	return router.Run() // Default to :8080
} 