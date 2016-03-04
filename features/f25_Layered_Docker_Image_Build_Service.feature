Feature: Layered Docker Image Build Service for Fedora
    https://fedoraproject.org/wiki/Changes/Layered_Docker_Image_Build_Service

    Fedora currently ships a Docker base image, but Docker supports a layering
    concept. This change will deploy the build service to support building and
    delivering a set of layered Docker images, and will enable Fedora 
    contributors to create and maintain Dockerfiles from which those images will
    be generated.


    Background: Fedora 25
        Given the target release is Fedora 25

    @releng
    Scenario: automatic Docker image rebuilds in case of new RPM build
        Given there is an existing Docker image built in Koji
          And the image depends on particular RPM package
         When a new RPM version is built in Koji
         Then a new build of the Docker image is triggered automatically by Koji.

    @releng
    Scenario: automatic Docker image releases in case of RPM update
        Given there is an existing Docker image built in Koji
          And the image depends on particular RPM package
         When a new RPM version makes it through Bodhi into Fedora Updates repo
         Then a new build of the Docker image is triggered automatically by Koji
          And the newly built image is pushed to Bodhi for testing.

    @releng
    Scenario: automatic Docker image rebuilds in case of layered image updates
        Given there is an existing Docker image for Jenkins
          And it is built on top of existing Docker image for Apache HTTPD
         When the Apache image is updated
         Then a new build of the Jenkins image is trigerred automatically by Koji.

    @maintainer
    Scenario: Docker images can be signed
        Given there is a Docker image built
         When the maintainer wants to publish it to the Fedora Registry
         Then he is able to sign the image using the `xxxx` command.

    @docker_user
    Scenario: users can verify Docker images content
        Given there is a signed Docker image
         When the user wants to verify its content
         Then the user is able to verify the image signature
          And the user is able to verify signatures of intermediate images used to
              build the current image
          And the user is able to verify signatures of individual RPM packages
              used to build this image.





