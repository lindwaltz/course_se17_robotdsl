/*
 * generated by Xtext 2.11.0
 */
package se.chalmers.turtlebotmission.idea.facet

import com.intellij.openapi.components.PersistentStateComponent
import com.intellij.openapi.components.State
import com.intellij.openapi.components.Storage
import com.intellij.openapi.components.StoragePathMacros
import com.intellij.openapi.components.StorageScheme
import org.eclipse.xtext.idea.facet.AbstractFacetConfiguration
import org.eclipse.xtext.idea.facet.GeneratorConfigurationState

@State(name = "se.chalmers.turtlebotmission.MissionDslGenerator", storages = #[
		@Storage(id = "default", file = StoragePathMacros.PROJECT_FILE),
		@Storage(id = "dir", file = StoragePathMacros.PROJECT_CONFIG_DIR
				+ "/MissionDslGeneratorConfig.xml", scheme = StorageScheme.DIRECTORY_BASED)])
 class MissionDslFacetConfiguration extends AbstractFacetConfiguration implements PersistentStateComponent<GeneratorConfigurationState>{

}