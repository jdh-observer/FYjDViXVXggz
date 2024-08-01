FROM rocker/geospatial:4.2.2

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

ENV NB_USER=rstudio
ENV VIRTUAL_ENV=/opt/venv
ENV PATH=${VIRTUAL_ENV}/bin:${PATH}

RUN /rocker_scripts/install_jupyter.sh

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

## Install Python citation manager
RUN python -m pip install --upgrade pip
RUN pip install jupyterlab-citation-manager

# Copy the current directory contents into the container at /home/rstudio
COPY . /home/rstudio

EXPOSE 8888

#CMD ["/bin/sh", "-c", "jupyter lab --ip 0.0.0.0 --no-browser"]

USER ${NB_USER}

# Set the working directory to the user's home directory
WORKDIR /home/rstudio

# Start Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]