# Use a base image with CUDA and CuDNN support for GPU-enabled PyTorch
FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

# Install Python and other necessary packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install required Python packages
WORKDIR /app
COPY requirements.txt requirements.txt
RUN python3 -m venv venv \
    && . venv/bin/activate \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy the Python script and other necessary files
COPY . .

# Expose the port chainlit will use
EXPOSE 7865

# Start the chainlit server
CMD ["/bin/bash", "-c", "source venv/bin/activate && python3 app.py"]
