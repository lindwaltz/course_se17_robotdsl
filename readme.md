About
=====
This is a small DSL for specifying TurtleBot Missions. Part of CourseWork.

[![CircleCI](https://circleci.com/gh/lindwaltz/course_se17_robotdsl.svg?style=svg)](https://circleci.com/gh/lindwaltz/course_se17_robotdsl)

Building and Running
====================

To build and run unit tests, just run

```
gradlew build
```

To start an interactive web-based editor, with live generation of output python code at http://localhost:8080 

```
gradlew jettyRun
```

![editor screenshot](https://raw.githubusercontent.com/lindwaltz/course_se17_robotdsl/master/examples/editor_preview.png)

IDE Installation
================

Note: **strongly** recommend the use of IntelliJ over Eclipse.

IntelliJ
--------

- Download
- Configure |> Plugins |> Manage Repositories |> Add
  `http://download.eclipse.org/modeling/tmf/xtext/idea/2.9.2/updatePlugins.xml`
- Tick all checkboxes (three) and update

- Choose Open Project, navigate to where you checked out this project. Done!

Eclipse Development
-------------------
**WARNING!** Eclipse is an odd animal. Don't use it unless you are already used to it. Go with IntelliJ if you can, it functions like most other IDEs out there - so whatever you learn or already known will be a lot more available for reuse.

### Installing

#### Eclipse
* Download Eclipse Neon (64-bit) from https://www.eclipse.org/downloads/

#### Xtext

- Follow the Xtext installation instructions on https://eclipse.org/Xtext/download.html (copied below for your convenience)

```
- Choose Help -> Install New Software... from the menu bar

- Insert in 'Work with': http://download.eclipse.org/modeling/tmf/xtext/updates/composite/releases/

- Select the following categories: Xtext, Xtend, MWE, EMF XCore,

- Complete the wizard by clicking the Next button until you can click Finish.

- After download and a restart of Eclipse, Xtext is ready to use.

```

#### Eclipse Modeling Framework

- Choose Help -> Install New Software... from the menu bar...
- Use Pull-Down and Choose Neon repository
- Search and add *EMF - Eclipse Modeling Framework SDK*
- Search and add *Ecore Diagram Editor (SDK)*

### Eclipse Actions
- **Generate AST (metamodel) classes**: Open `turtlebotmission.genmodel`, right click and select `Generate All`

- **Generate language code**: When editing `.xtext/TurtleBotMissionDSL.xtext` right click and `Run As -> Generate Xtext Artifacts`.

Project Layout
==============
The main project is `.turtlebotmission`, it contains the `.xtext` file and the automatically generated `.ecore` definition. (Note that I do not use a custom ecore).

```
.turtlebotmission/
  :: contains xtext grammar definition, generated ecore model and generated java classes. Exports 'http://www.chalmers.se/turtlebotmission' package (turtlebotmission.TurtlebotmissionPackage)

.turtlebotmission.ide/
  :: auto-generated IDE-integration code. Dont touch.

.turtlebotmission.idea/
  :: auto-generated IDE-integration code. Dont touch.

.turtlebotmission.web/
  :: partly generated/manual code for running the interactive web service. You shouldn't need to modify this.
```

Grammar
-------
The grammar at [turtlebotmission.xtext](https://github.com/lindwaltz/course_se17_robotdsl/blob/master/se.chalmers.turtlebotmission/src/main/java/se/chalmers/turtlebotmission.xtext) has mostly minor modifications from the grammar generated from the supplied `.ecore` definitions.

First off, it uses `WS` to handle optional whitespace and `(SL|ML)_COMMENT` for comments. Other than that it allows the arbitrary ordering of TurtleBot-level statements by using `&` between groups.

Code generation
---------------
The code generator uses Xtext `IGeneratorService` interface to generate code, making it callable from various contexts as intended by Xtext makers. In order to generate the python code, [Velocity Templates](http://velocity.apache.org/) and a template file [mission.py.vm](https://github.com/lindwaltz/course_se17_robotdsl/blob/master/se.chalmers.turtlebotmission/src/main/resources/templates/mission.py.vm)

Examples
--------

See [examples/ folder](https://github.com/lindwaltz/course_se17_robotdsl/tree/master/examples) for DSL samples.

References
==========

Essential
---------
- [1] http://www.cs.kun.nl/J.Hooman/DSL/Xtext_DSL_GettingStarted_Mars.pdf

- [2] http://www.vogella.com/tutorials/EclipseEMF/article.html

- [3] https://rtsys.informatik.uni-kiel.de/confluence/display/TUT/Xtext+1+-+Creating+a+Grammar+for+an+Existing+Metamodel

- https://eclipse.org/Xtext/documentation/301_grammarlanguage.html

- https://eclipse.org/xtend/documentation/203_xtend_expressions.html

Periphery
---------
- http://www.lorenzobettini.it/2014/04/switching-to-xcore-in-your-xtext-language/

- http://www.lorenzobettini.it/2014/02/switching-from-an-inferred-ecore-model-to-an-imported-one-in-your-xtext-grammar/

- https://blogs.itemis.com/en/building-xtext-dsls-with-gradle

- https://blogs.itemis.com/en/using-xtext-with-xcore-and-gradle

- https://www.packtpub.com/books/content/testing-xtext-and-xtend

- https://github.com/eclipse/xtext-web/blob/master/org.eclipse.xtext.web.example.jetty/src/main/webapp/ace-statemachine-resource.html

- http://codereview.stackexchange.com/questions/81865/travelling-salesman-using-brute-force-and-heuristics

Unused
------
(but saved for the future)

- https://www.eclipsecon.org/france2015/sites/default/files/slides/presentation.pdf

- http://stackoverflow.com/questions/36120699/generate-emf-model-via-gradle
