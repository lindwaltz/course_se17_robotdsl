/*
 * xtext gen. the original - now customized for TurtlebotMission!
 */
package se.chalmers.turtlebotmission.web

import com.google.inject.Guice
import com.google.inject.Injector
import org.eclipse.xtext.util.Modules2
import se.chalmers.turtlebotmission.MissionDslRuntimeModule
import se.chalmers.turtlebotmission.MissionDslStandaloneSetup
import se.chalmers.turtlebotmission.ide.MissionDslIdeModule

import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
/**
 * Initialization support for running Xtext languages in web applications.
 */
@FinalFieldsConstructor
class MissionDslWebSetup extends MissionDslStandaloneSetup {
	val IResourceBaseProvider resourceBaseProvider
	
	override Injector createInjector() {
		return Guice.createInjector(Modules2.mixin(
                new MissionDslRuntimeModule,
                new MissionDslIdeModule,
                new MissionDslWebModule(resourceBaseProvider)))
	}
}
