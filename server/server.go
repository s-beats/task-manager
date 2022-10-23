package server

import (
	"context"
	"net"
	"net/http"
	"os"

	"github.com/s-beats/rest-todo/log"

	"github.com/s-beats/rest-todo/infra/rdb"
	"github.com/s-beats/rest-todo/infra/rdb/persistence"
	"github.com/s-beats/rest-todo/usecase"
)

func Start() error {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")
	return http.ListenAndServe(net.JoinHostPort(host, port), nil)
}

func usecaseMiddlewarefunc(f http.HandlerFunc) http.HandlerFunc {
	type contextKey string
	const (
		contextKeyTaskUsecase contextKey = "taskUsecase"
		contextKeyUserUsecase contextKey = "userUsecase"
	)

	return func(w http.ResponseWriter, r *http.Request) {
		db, err := rdb.NewDB()
		if err != nil {
			log.Fatal().Err(err)
		}

		taskRepo := persistence.NewTask(db)
		userRepo := persistence.NewUser(db)
		taskUsecase := usecase.NewTask(taskRepo, userRepo)
		userUsecase := usecase.NewUser(userRepo)

		r = r.WithContext(context.WithValue(r.Context(), contextKeyTaskUsecase, taskUsecase))
		r = r.WithContext(context.WithValue(r.Context(), contextKeyUserUsecase, userUsecase))

		f(w, r)
	}
}
