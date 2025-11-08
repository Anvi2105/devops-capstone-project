FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY service/ ./service/

# Expose the application port
EXPOSE 8080

# Create a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the application
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
