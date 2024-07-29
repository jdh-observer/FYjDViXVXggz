## Use a tag instead of "latest" for reproducibility
FROM rocker/binder:4

## Declares build arguments
ARG NB_USER
ARG NB_UID
ARG NB_GID

## Copies your repo files into the Docker Container
USER root
RUN apt-get update && apt-get -y install libgsl-dev
COPY . /home/${NB_USER}

## Run an install.R script, if it exists.
RUN if [ -f /home/${NB_USER}/install.R ]; then R --quiet -f /home/${NB_USER}/install.R; fi

## Enable this to copy files from the binder subdirectory
## to the home, overriding any existing files.
## Useful to create a setup on binder that is different from a
## clone of your repository
## COPY binder /home/${NB_USER}
RUN chown -R ${NB_UID}:${NB_GID} /home/${NB_USER}

## Become normal user again
USER ${NB_USER}

## Set permissions for the notebook files
RUN chmod -R u+w /home/${NB_USER}

## Start the notebook server
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser"]