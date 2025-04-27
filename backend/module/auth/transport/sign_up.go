package transport

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/longan18/manage/backend/module/auth/business"
	"github.com/longan18/manage/backend/module/auth/entities"
	"github.com/longan18/manage/backend/module/auth/storage"
	"gorm.io/gorm"
)

func SignUp(db *gorm.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var data auth.AuthRegister

		if err := c.ShouldBindJSON(&data); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		storage := storage.NewPostgresStorage(db)
		biz := business.NewRegisterBusiness(storage)

		if err := biz.Register(c.Request.Context(), &data); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": "Register successfully"})
	}
}