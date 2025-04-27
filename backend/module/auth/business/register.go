package business

import (
	"context"

	"github.com/longan18/manage/backend/common"
	"github.com/longan18/manage/backend/module/auth/entities"
)

type RegisterStorage interface {
	Register(ctx context.Context, data *auth.AuthRegister) error
}

type registerBusiness struct {
	storage RegisterStorage
}

func NewRegisterBusiness(storage RegisterStorage) *registerBusiness {
	return &registerBusiness{storage: storage}
}

func (b *registerBusiness) Register(ctx context.Context, data *auth.AuthRegister) error {

	hashedPassword, err := common.HashPassword(data.PasswordHash)
	if err != nil {
		return err
	}

	data.PasswordHash = hashedPassword

	if err := b.storage.Register(ctx, data); err != nil {
		return err
	}

	return nil
}


