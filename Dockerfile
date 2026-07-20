FROM python:3.10

# Set working directory
WORKDIR /app

# Copy requirements and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Make migrations and migrate (useful for sqlite)
RUN python manage.py makemigrations
RUN python manage.py migrate

# Expose the port Hugging Face Spaces uses
EXPOSE 7860

# Run gunicorn on port 7860
CMD ["gunicorn", "-b", "0.0.0.0:7860", "PORTFOLIO.wsgi:application"]
