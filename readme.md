IDE Installation
================

IntelliJ
--------

- Download
- Configure |> Plugins |> Manage Repositories |> Add
  `http://download.eclipse.org/modeling/tmf/xtext/idea/2.9.2/updatePlugins.xml`
- Tick all checkboxes (three) and update

Eclipse Development
-------------------
**WARNING!** Eclipse is an odd animal. Don't use it unless you are already used to it. Go with IntelliJ if you can, it functions like most other IDEs out there - so whatever you learn or already known will be a lot more available for reuse.

#### Installing

### Eclipse
* Download Eclipse Neon (64-bit) from https://www.eclipse.org/downloads/

### Xtext

- Follow the Xtext installation instructions on https://eclipse.org/Xtext/download.html (copied below for your convenience)

```
- Choose Help -> Install New Software... from the menu bar

- Insert in 'Work with': http://download.eclipse.org/modeling/tmf/xtext/updates/composite/releases/

- Select the following categories: Xtext, Xtend, MWE, EMF XCore,

- Complete the wizard by clicking the Next button until you can click Finish.

- After download and a restart of Eclipse, Xtext is ready to use.

```

### Eclipse Modeling Framework

- Choose Help -> Install New Software... from the menu bar...
- Use Pull-Down and Choose Neon repository
- Search and add *EMF - Eclipse Modeling Framework SDK*
- Search and add *Ecore Diagram Editor (SDK)*

Eclipse Actions
---------------
- **Generate AST (metamodel) classes**: Open `turtlebotmission.genmodel`, right click and select `Generate All`

- **Generate language code**: When editing `.xtext/TurtleBotMissionDSL.xtext` right click and `Run As -> Generate Xtext Artifacts`.

Project Layout
==============
The two main projects to look at are `.turtlebotmission` and `.turtlebotmission.xtext`. The prior one contains the meta model definition (in a `.ecore` and its associated `.genmodel` file). These two files (???) lead to the generation of the POJO classes in `.turtlebotmission/src`. Futhermore, for this exercise, the given `.xtext` file (mentioned below) has been automatically generated from the meta model (*it will be your task to customize it*), see [3] for how it was generated.

In `.turtlebotmission.xtext` the main file to look at is `TurtleBotMissionDSL.xtext` that defines the grammar for the language. You can ignore all `.xtend` files since these are not used in this project. The `.mwe2` file defines some settings for xtext, which you won't need to modify.

```
.turtlebotmission/
  :: contains ecore model and generated java classes. Exports 'http://www.chalmers.se/turtlebotmission' package (turtlebotmission.TurtlebotmissionPackage)

  model/
    turtlebotmission.ecore                  Defined classes and relationships.
    turtlebotmission.genmodel               Additional code generation options.
    turtlebotmission.aird                   Visualization settings for class diagram.
  
  src/                                      Auto-Generated from the ecore/genmodel files.

```

See http://www.vogella.com/tutorials/EclipseEMF/article.html#meta-models-ecore-and-genmodel for a good explanation of `.ecore` and `.genmodel`.

```
.turtlebotmission/xtext
  :: xtext grammar and generated parsing code. Imports and references '.turtlebotmission' AST.

  src/
    TurtleBotMissionDSL.xtext               Grammar definition
```

```
.turtlebotmission.rosstarter/
  :: Plugin for .TurtleBotMissionDSL editor - adds a button that can be pressed
     to generate python code from the currently opened file.
```

```
.turtlebotmission.xtext.ide/
  :: auto-generated IDE-integration code. Dont touch.
```

```
.turtlebotmission.xtext.ui/
  :: auto-generated code. Dont touch.
```

```
.turtlebotmission.edit/
  :: auto-generated editor code. Dont touch.
```

```
.turtlebotmission.editor/
  :: auto-generated editor code. Dont touch.
```

References
==========

Essential
---------
- [1] http://www.cs.kun.nl/J.Hooman/DSL/Xtext_DSL_GettingStarted_Mars.pdf

- [2] http://www.vogella.com/tutorials/EclipseEMF/article.html

- [3] https://rtsys.informatik.uni-kiel.de/confluence/display/TUT/Xtext+1+-+Creating+a+Grammar+for+an+Existing+Metamodel

Periphery
---------
- http://www.lorenzobettini.it/2014/04/switching-to-xcore-in-your-xtext-language/

- http://www.lorenzobettini.it/2014/02/switching-from-an-inferred-ecore-model-to-an-imported-one-in-your-xtext-grammar/

- https://blogs.itemis.com/en/building-xtext-dsls-with-gradle

- https://blogs.itemis.com/en/using-xtext-with-xcore-and-gradle


Unused
------
- https://www.eclipsecon.org/france2015/sites/default/files/slides/presentation.pdf

- http://stackoverflow.com/questions/36120699/generate-emf-model-via-gradle