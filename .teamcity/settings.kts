import jetbrains.buildServer.configs.kotlin.v2019_2.*
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.gradle
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.mavenArtifact
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs
import jetbrains.buildServer.configs.kotlin.v2019_2.vcs.GitVcsRoot

/*
The settings script is an entry point for defining a TeamCity
project hierarchy. The script should contain a single call to the
project() function with a Project instance or an init function as
an argument.

VcsRoots, BuildTypes, Templates, and subprojects can be
registered inside the project using the vcsRoot(), buildType(),
template(), and subProject() methods respectively.

To debug settings scripts in command-line, run the

    mvnDebug org.jetbrains.teamcity:teamcity-configs-maven-plugin:generate

command and attach your debugger to the port 8000.

To debug in IntelliJ Idea, open the 'Maven Projects' tool window (View
-> Tool Windows -> Maven Projects), find the generate task node
(Plugins -> teamcity-configs -> teamcity-configs:generate), the
'Debug' option is available in the context menu for the task.
*/

version = "2020.1"

project {

    vcsRoot(HttpsGithubComRugpanovTeamcityInvestigationsAutoAssignerRefsHeadsMaster)

    subProject(Subproject)
}

object HttpsGithubComRugpanovTeamcityInvestigationsAutoAssignerRefsHeadsMaster : GitVcsRoot({
    name = "https://github.com/rugpanov/teamcity-investigations-auto-assigner#refs/heads/master"
    url = "https://github.com/rugpanov/teamcity-investigations-auto-assigner"
})


object Subproject : Project({
    name = "subproject"

    buildType(AutoAssignerSources)
})

object AutoAssignerSources : BuildType({
    name = "auto-assigner-sources"

    vcs {
        root(HttpsGithubComRugpanovTeamcityInvestigationsAutoAssignerRefsHeadsMaster)
    }

    steps {
        gradle {
            tasks = "clean build"
            buildFile = ""
            gradleWrapperPath = ""
        }
    }

    triggers {
        mavenArtifact {
            groupId = "com.baz.foobar"
            artifactId = "foobar"
            version = "[1.0,)"
            artifactType = "jar"

            repoUrl = "https://packages.jetbrains.team/maven/at-test"
            repoId = "foobar-release"
            userSettingsSelection = "buildTrigger.xml"
        }
    }
})
