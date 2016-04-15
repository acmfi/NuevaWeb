package dao

import play.api.libs.concurrent.Execution.Implicits._
import scala.concurrent.Future
import models.Sig
import play.api.db.slick.DatabaseConfigProvider
import play.api.db.slick.HasDatabaseConfigProvider
import slick.driver.JdbcProfile
import javax.inject.Inject

class SigDAO @Inject()(protected val dbConfigProvider: DatabaseConfigProvider) extends HasDatabaseConfigProvider[JdbcProfile] {
  import dbConfig.driver.api._

  private val Sigs = TableQuery[SigTable]

  def all(): Future[Seq[Sig]] = db.run(Sigs.result)

  def get(id: String): Future[Seq[Sig]] = db.run(Sigs.filter(s => s.id === id).result)

  def insert(news: Sig): Future[Unit] = db.run(Sigs += news).map { _ => () }

  private class SigTable(tag: Tag) extends Table[Sig](tag, "Sig") {
    def id = column[String]("id", O.PrimaryKey)
    def name = column[String]("name")
    def description = column[String]("description")

    def * = (id, name, description) <> (Sig.tupled, Sig.unapply)
  }}
