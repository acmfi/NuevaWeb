package controllers

import play.api.libs.concurrent.Execution.Implicits.defaultContext
import javax.inject.Inject
import dao.NewsDAO
import dao.EventDAO
import dao.SigDAO
import play.api._
import play.api.mvc._
import play.api.db.slick.DatabaseConfigProvider
import slick.driver.JdbcProfile
import models.News

class Application @Inject()(newsDao: NewsDAO, eventsDao: EventDAO, sigsDao: SigDAO) extends Controller {

  val dbConfig = DatabaseConfigProvider.get[JdbcProfile](Play.current)

  def index = Action.async {
    //val not: News = News(0,"Noticia", "Contenido de la noticia.", 1410000000)
    //newsDao.insert(not)
    newsDao.latest().map{ news => Ok(views.html.index("Principal - ACM UPM")(news)) }
  }

  def login = Action {
    Ok(views.html.login("Login - ACM UPM"))
  }

  def info = Action {
    Ok(views.html.info("Info - ACM UPM"))
  }

  def events = Action.async {
    eventsDao.all().map{ events => Ok(views.html.events("Eventos - ACM UPM")(events)) }
  }

  def sigs = Action.async {
    sigsDao.all().map{ sigs => Ok(views.html.sigs("SIGs - ACM UPM")(sigs)) }
  }

  def sig(id: String) = Action.async {
    sigsDao.get(id).map{ sig => Ok(views.html.sig("SIG - ACM UPM")(sig.head)) }
  }

  def event(id: Long) = Action.async {
    eventsDao.get(id).map{ event => Ok(views.html.event("Evento - ACM UPM")(event.head)) }
  }

//  def contact = Action {
//    Ok(views.html.contact())
//  }

}
