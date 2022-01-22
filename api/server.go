package api

import (
	"fmt"
	"github.com/FullStackBlog/api/controllers"
	"github.com/FullStackBlog/api/seed"
	"github.com/joho/godotenv"
	"log"
	"os"
)

var server = controllers.Server{}

func Run() {

	var err error
	err = godotenv.Load()
	if err != nil {
		log.Fatalln("Error in loading the dotenv file :" + err.Error())
	} else {
		fmt.Println("We are getting values from dotenv file")
	}

	server.Initialize(os.Getenv("DB_DRIVER"), os.Getenv("DB_USER"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_PORT"), os.Getenv("DB_HOST"), os.Getenv("DB_NAME"))

	seed.Load(server.DB)

	server.Run(":8090")

}
