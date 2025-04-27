package storage

import (
	"context"

	"github.com/longan18/manage/backend/module/auth/entities"
)

func (s *postgresStorage) Register(ctx context.Context, data *auth.AuthRegister) error {
	if err := s.db.Create(data).Error; err != nil {
		return err
	}

	return nil
}
