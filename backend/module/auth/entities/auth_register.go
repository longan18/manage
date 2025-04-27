package auth


type AuthRegister struct {
	Id       int8   `json:"id" gorm:"column:id"`
	Email    string `json:"email" gorm:"column:email"`
	PasswordHash string `json:"password_hash" gorm:"column:password_hash"`
	
}

func (AuthRegister) TableName() string { return "manage.users" }