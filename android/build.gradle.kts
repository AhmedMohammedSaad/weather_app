allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.afterEvaluate {
        val android = project.extensions.findByName("android")
        if (android != null) {
            val intPrimitive = Int::class.javaPrimitiveType ?: Int::class.java
            try {
                val method = android.javaClass.getMethod("compileSdkVersion", intPrimitive)
                method.invoke(android, 36)
            } catch (e: Exception) {}
            try {
                val method = android.javaClass.getMethod("setCompileSdkVersion", intPrimitive)
                method.invoke(android, 36)
            } catch (e: Exception) {}
            try {
                val method = android.javaClass.getMethod("setCompileSdk", java.lang.Integer::class.java)
                method.invoke(android, 36)
            } catch (e: Exception) {}
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
