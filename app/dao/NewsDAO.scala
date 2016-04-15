package dao

import play.api.libs.concurrent.Execution.Implicits._
import scala.concurrent.Future
import models.News
import play.api.db.slick.DatabaseConfigProvider
import play.api.db.slick.HasDatabaseConfigProvider
import slick.driver.JdbcProfile
import javax.inject.Inject

class NewsDAO @Inject()(protected val dbConfigProvider: DatabaseConfigProvider) extends HasDatabaseConfigProvider[JdbcProfile] {
  import dbConfig.driver.api._

  private val NewsT = TableQuery[NewsTable]

  def latest(): Future[Seq[News]] = db.run(NewsT.result)

  def insert(news: News): Future[Unit] = db.run(NewsT += news).map { _ => () }

  private class NewsTable(tag: Tag) extends Table[News](tag, "News") {
    def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
    def title = column[String]("title")
    def content = column[String]("content")
    def date = column[Long]("date")

    def * = (id, title, content, date) <> (News.tupled, News.unapply)
  }
}

