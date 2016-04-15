package dao

import play.api.libs.concurrent.Execution.Implicits._
import scala.concurrent.Future
import models.Event
import play.api.db.slick.DatabaseConfigProvider
import play.api.db.slick.HasDatabaseConfigProvider
import slick.driver.JdbcProfile
import javax.inject.Inject

class EventDAO @Inject()(protected val dbConfigProvider: DatabaseConfigProvider) extends HasDatabaseConfigProvider[JdbcProfile] {
  import dbConfig.driver.api._

  private val Events = TableQuery[EventTable]

  def all(): Future[Seq[Event]] = db.run(Events.result)

  def get(id: Long): Future[Seq[Event]] = db.run(Events.filter(e => e.id === id).result)

  def insert(news: Event): Future[Unit] = db.run(Events += news).map { _ => () }

  private class EventTable(tag: Tag) extends Table[Event](tag, "Event") {
    def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
    def title = column[String]("title")
    def location = column[String]("location")
    def date = column[Long]("date")
    def description = column[String]("description")

    def * = (id, title, date, location, description) <> (Event.tupled, Event.unapply)
  }
}
