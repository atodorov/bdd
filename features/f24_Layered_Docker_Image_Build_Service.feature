Feature: Layered Docker Image Build Service for Fedora
    https://fedoraproject.org/wiki/Changes/Layered_Docker_Image_Build_Service

    Fedora currently ships a Docker base image, but Docker supports a layering
    concept. This change will deploy the build service to support building and
    delivering a set of layered Docker images, and will enable Fedora 
    contributors to create and maintain Dockerfiles from which those images will
    be generated.

    Background: Fedora 24
        Given the target release is Fedora 24

    @maintainer
    Scenario: packaging guidelines for Dockerfiles
        Given a maintainer wants to build a new Docker image
         When they want to check what Dockerfile syntax is considered
              best-practice
         Then a Packaging Guidelines for Dockerfiles exists
          And they will consult the Packaging Guidelines for Dockerfiles
              document.

    @maintainer
    Scenario: store Dockerfiles in dist-git
        Given an approved maintainer has created a new Dockerfile
         Then they can commit the Dockerfile in dist-git under
              /srv/git/repositories/docker/<pkg>.git.

    @maintainer
    Scenario: build a Docker image in Koji
        Given a maintainer wants to build a new Docker image
         When they use the `fedpkg container-build`command
         Then a `fedpkg container-build` command exists
          And when executed Koji produces the resulting Docker image.

    @releng
    Scenario: ensure Docker image content comes from Fedora
        Given a maintainer has built a new image in Koji
         Then all content inside the image matches existing RPM content from
              Fedora.

    @releng
    Scenario: build artifacts from Koji are integrated in Fedora composes
        Given there are Docker images built in Koji
         When a new Fedora compose is created (e.g. Alpha, Beta, RC)
         Then the compose artifacts will reference all available Docker images
              at that time.

    @docker_user
    Scenario: built Docker images should be in Fedora Docker registry
        Given a new Docker image is built in Koji
         Then the image is uploaded to registry.fedoraproject.org
          And the image/registry is available to the docker client side tools.

    @releng
    Scenario: newly released Docker images are pushed to mirrors
        Given a Docker image is pushed to Fedora Docker registry
         Then the image file is automatically synchronized around the Fedora
              mirrors infrastructure.

    @releng, @docker_user
    Scenario: built Docker images should be in Upstream Docker registry
        Given a new Docker image is built in Koji
         Then the image is uploaded to hub.docker.com
          And the Fedora image is available to the docker client side tools.


    @releng
    Scenario: Building RPM with the same name as Docker image doesn't led to data loss
        Given there is an RPM package called "jenkins"
          And a Docker image called "jenkins"
         When `fedpkg build jenkins` is executed
         Then the newly built Jenkins RPM is available in Koji
          And previous versions of Jenkins RPM continue to be available in Koji
          And all versions of Jenkins image continue to be available in Koji.

    @releng
    Scenario: Building Docker image with the same name as RPM doesn't cause data loss
        Given there is a Docker image called "jenkins"
          And an RPM package called "jenkins"
         When `fedpkg container-build jenkins` is executed
         Then the newly built Jenkins image is available in Koji
          And previous versions of Jenkins images continue to be available in Koji
          And all versions of Jenkins RPM continue to be available in Koji.
