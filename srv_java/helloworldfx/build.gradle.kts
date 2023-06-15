plugins {
    id("java")
    id("application")
    id("org.openjfx.javafxplugin") version "0.0.14"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven {
        setUrl("https://plugins.gradle.org/m2/")
    }
}

dependencies {
    implementation("joda-time:joda-time:2.12.5")
    testImplementation(platform("org.junit:junit-bom:5.9.1"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    implementation("org.openjfx:javafx-plugin:0.0.14")
    testImplementation("org.openjfx:javafx-plugin:0.0.14")
    testImplementation("org.junit.jupiter:junit-jupiter:5.8.2")
    compileOnly("org.openjfx:javafx-base:17")
    compileOnly("org.openjfx:javafx-graphics:17")
    compileOnly("org.openjfx:javafx-controls:17")
}

tasks.test {
    useJUnitPlatform()
}

javafx {
    modules("javafx.controls", "javafx.fxml", "javafx.graphics", "javafx.base","javafx.web","javafx.media")
}