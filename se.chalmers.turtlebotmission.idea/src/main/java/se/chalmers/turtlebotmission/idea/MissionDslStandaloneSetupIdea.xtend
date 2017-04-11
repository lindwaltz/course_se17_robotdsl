/*
 * generated by Xtext 2.11.0
 */
package se.chalmers.turtlebotmission.idea

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import se.chalmers.turtlebotmission.MissionDslRuntimeModule
import se.chalmers.turtlebotmission.MissionDslStandaloneSetupGenerated

class MissionDslStandaloneSetupIdea extends MissionDslStandaloneSetupGenerated {
	override createInjector() {
		val runtimeModule = new MissionDslRuntimeModule()
		val ideaModule = new MissionDslIdeaModule()
		val mergedModule = Modules2.mixin(runtimeModule, ideaModule)
		return Guice.createInjector(mergedModule)
	}
}