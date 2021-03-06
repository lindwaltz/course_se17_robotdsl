/*
 * xtext gen. the original - now customized for TurtlebotMission!
 */
package se.chalmers.turtlebotmission.web

import javax.servlet.annotation.WebServlet
import org.eclipse.xtext.util.DisposableRegistry
import org.eclipse.xtext.web.servlet.XtextServlet

import org.eclipse.xtext.web.server.persistence.ResourceBaseProviderImpl

/**
 * Deploy this class into a servlet container to enable DSL-specific services.
 */
@WebServlet(name = 'XtextServices', urlPatterns = '/xtext-service/*')
class MissionDslServlet extends XtextServlet {
	
	DisposableRegistry disposableRegistry
	
	override init() {
		super.init()

        // initialize persistence repository
        val resourceBaseProvider = new ResourceBaseProviderImpl('./test-files')

		val injector = new MissionDslWebSetup(resourceBaseProvider).createInjectorAndDoEMFRegistration()
		disposableRegistry = injector.getInstance(DisposableRegistry)
	}

	override destroy() {
		if (disposableRegistry !== null) {
			disposableRegistry.dispose()
			disposableRegistry = null
		}
		super.destroy()
	}
	
}
