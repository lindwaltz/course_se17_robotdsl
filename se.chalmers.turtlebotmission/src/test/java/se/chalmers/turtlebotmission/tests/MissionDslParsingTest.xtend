/*
 * xtext gen. the original - now customized for TurtlebotMission!
 */
package se.chalmers.turtlebotmission.tests

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import se.chalmers.turtlebotmission.turtlebotmission.TurtleBot

@RunWith(XtextRunner)
@InjectWith(MissionDslInjectorProvider)
class MissionDslParsingTest {
	@Inject
	ParseHelper<TurtleBot> parseHelper

    @Inject extension ParseHelper<TurtleBot>
    @Inject extension ValidationTestHelper

    @Test
	def void simpleEmptyModel() {
		val result = parseHelper.parse('''
			TurtleBot test{}
		''')
        if (result === null) {
            System.out.println("ERROR: ParseHelper failed to parse TurtleBot instance. Weird error?!")
        }
		Assert.assertNotNull(result)

		System.out.println(result)
		val noErrors = result.eResource().getErrors().isEmpty()
		if (!noErrors) {
			result.eResource().getErrors().forEach[el,idx | System.out.println(el)]
		}
		Assert.assertTrue(noErrors)
	}

    @Test
    def void basicExample01() {
        val content = loadFile("examples/example.tbm")
        parseHelper.parse(content).assertNoErrors
    }

    def String loadFile(String path) {
        val currentDirectory = new File(new File(".").getAbsolutePath());

        var p = Paths.get(currentDirectory.getAbsolutePath(), path)
        for (String ps : newArrayList(".", "..", "../..")) {
            val t = Paths.get(currentDirectory.getAbsolutePath(), ps, path)
            if(Files.exists(t)) {
                p = t
            }
        }

        val content = String.join("\n", Files.readAllLines(p))

        return content
    }
}
