# Use the rocker/binder image, which includes R and Jupyter Notebook
FROM rocker/binder:4

# Set build arguments with default values
ARG NB_USER
ARG NB_UID=1000
ARG NB_GID=100

# Install additional packages if needed
USER root
RUN apt-get update && apt-get -y install libgsl-dev

# Create the user directory if it doesn't exist and set permissions
RUN mkdir -p /home/${NB_USER} && chown -R ${NB_UID}:${NB_GID} /home/${NB_USER}

# Copy your repository files into the container
COPY . /home/${NB_USER}

# Run an install.R script, if it exists
RUN if [ -f /home/${NB_USER}/install.R ]; then R --quiet -f /home/${NB_USER}/install.R; fi

# Change ownership of the home directory to the specified user and group
RUN chown -R ${NB_UID}:${NB_GID} /home/${NB_USER}

# Switch back to the notebook user
USER ${NB_USER}

# Set permissions for the notebook files
RUN chmod -R u+w /home/${NB_USER}

# Ensure the .ipynb_checkpoints directory exists and has the correct permissions
RUN mkdir -p /home/${NB_USER}/.ipynb_checkpoints && chmod -R u+w /home/${NB_USER}/.ipynb_checkpoints

# Start the notebook server
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser"]