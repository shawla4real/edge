3he-dir -r requirements.txt
# RUN apt-get update && \
#     apt-get install -y python3

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
