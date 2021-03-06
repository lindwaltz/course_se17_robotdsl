/*
 * xtext gen. the original - now customized for TurtlebotMission!
 */
package se.chalmers.turtlebotmission.web

import com.google.inject.Binder
import org.eclipse.xtext.web.server.persistence.FileResourceHandler
import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider
import org.eclipse.xtext.web.server.persistence.IServerResourceHandler
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

/**
 * Use this class to register additional components to be used within the web application.
 */
@FinalFieldsConstructor
class MissionDslWebModule extends AbstractMissionDslWebModule {
  val IResourceBaseProvider resourceBaseProvider

  def void configureResourceBaseProvider(Binder binder) {
    if (resourceBaseProvider !== null) binder.bind(IResourceBaseProvider).toInstance(resourceBaseProvider)
  }

  def Class<? extends IServerResourceHandler> bindIServerResourceHandler() {
    return FileResourceHandler
  }
}
