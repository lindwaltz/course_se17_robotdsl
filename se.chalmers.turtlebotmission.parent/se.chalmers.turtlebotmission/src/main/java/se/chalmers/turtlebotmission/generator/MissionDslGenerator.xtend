/*
 * xtext - customized
 */
package se.chalmers.turtlebotmission.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

import se.chalmers.turtlebotmission.turtlebotmission.TurtleBot

import java.io.StringWriter
import org.apache.velocity.app.Velocity;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

import se.chalmers.turtlebotmission.turtlebotmission.*
import se.chalmers.turtlebotmission.turtlebotmission.ShortestPathTask

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MissionDslGenerator extends AbstractGenerator {

    new() {
        Velocity.setProperty(Velocity.RESOURCE_LOADER, "classpath");
        Velocity.setProperty("classpath.resource.loader.class", typeof(ClasspathResourceLoader).getName())
        Velocity.init();
    }

    override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val tbm = resource.allContents.filter(TurtleBot).head
		if (tbm !== null) {
            val tmpl = Velocity.getTemplate("templates/mission.py.vm")
            val tc = new VelocityContext()

            // update context with model information
            tc.put("tbm", tbm)
            val missionSteps = newArrayList()

            var start_x = 0
            var start_y = 0
            if (tbm.bot_start !== null) {
                start_x = tbm.bot_start.coord_x
                start_y = tbm.bot_start.coord_y
            }

            // add initial position
            missionSteps.add("['goto_line', (" + start_x + "," + start_y + ")]")

            // add mission points
            for (Mission mission : tbm.missions) {
                for (Task task : mission.task) {
                    switch task {
                        ReturnToStartTask : missionSteps.add("['goto_line', (" + start_x + "," + start_y + ")]")
                        ShortestPathTask : {
                            val points = task.waypoints.map[e | "(" + e.coord_x + "," + e.coord_y + ")"]
                            val pointStr = String.join(",", points)
                            missionSteps.add("['goto_opt'," + "[" + pointStr + "]]")
                        }
                        LineTask : {
                            val points = task.waypoints.map[e | "(" + e.coord_x + "," + e.coord_y + ")"]
                            val pointStr = String.join(",", points)
                            missionSteps.add("['goto_line'," + "[" + pointStr + "]]")
                        }
                    }
                }
            }
            tc.put("steps", missionSteps)

            // render template and return
            val writer = new StringWriter()
            tmpl.merge(tc, writer)
            writer.flush()
			fsa.generateFile('/DEFAULT_ARTIFACT', writer.toString())
		} else {
			fsa.generateFile('/DEFAULT_ARTIFACT', "not parseable.")
		}
	}
}
