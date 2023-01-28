package main

import (
	"log"
	relation "tinytiktok/kitex_gen/relation/relationservice"
)

func main() {
	svr := relation.NewServer(new(RelationServiceImpl))

	err := svr.Run()

	if err != nil {
		log.Println(err.Error())
	}
}
