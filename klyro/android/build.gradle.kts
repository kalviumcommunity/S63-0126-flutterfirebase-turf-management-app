// Project-Level Gradle Configuration
plugins {
    // Registers Google Services plugin required by Firebase natively, preventing it from applying until sub-projects execute logic
    id("com.google.gms.google-services") version "4.3.15" apply false
}

// Tells Gradle where to download native Android libraries from globally
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Configures customized physical output build directory structure avoiding Flutter cache conflicts
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

// Layout structures dynamically mapping app sub-segments efficiently natively
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Evaluates dependencies dictating the build logic waits for :app module explicitly first concurrently
subprojects {
    project.evaluationDependsOn(":app")
}

// Registers terminal cleanup script tasks actively allowing `gradlew clean` to execute smoothly natively
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
