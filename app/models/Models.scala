package models

case class News(id: Long, title: String, content: String, date: Long)

case class Event(id: Long, title: String, date: Long, location: String, description: String)

case class Sig(id: String, name: String, description: String)
