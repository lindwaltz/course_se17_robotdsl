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
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.generator.InMemoryFileSystemAccess


@RunWith(XtextRunner)
@InjectWith(MissionDslInjectorProvider)
class MissionDslGeneratorTest {
	@Inject ParseHelper<TurtleBot> parseHelper

    @Inject extension ParseHelper<TurtleBot>
    @Inject extension ValidationTestHelper
    @Inject IGenerator2 sut

    @Test
	def void generateMinimal() {
		val result = parseHelper.parse('''
			TurtleBot test{}
		''')
        result.assertNoErrors

        val fsa = new InMemoryFileSystemAccess()
        sut.doGenerate(result.eResource, fsa, null)
        //fsa.allFiles.forEach[el,idx | println(el)]
        val output = fsa.allFiles.get("DEFAULT_OUTPUT/DEFAULT_ARTIFACT").toString()
        //println(output)
        Assert.assertTrue(output.contains("/usr/bin/env python"))
	}

    @Test
    def void generateBasicExample01() {
        val content = loadFile("examples/example.tbm")
        val result = parseHelper.parse(content)
        result.assertNoErrors

        val fsa = new InMemoryFileSystemAccess()
        sut.doGenerate(result.eResource, fsa, null)
        fsa.allFiles.forEach[el,idx | println(el)]
        val output = fsa.allFiles.get("DEFAULT_OUTPUT/DEFAULT_ARTIFACT").toString()
        println(output)
        Assert.assertTrue(output.contains("/usr/bin/env python"))
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
