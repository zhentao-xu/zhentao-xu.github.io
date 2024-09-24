# Use the official Jekyll image from Docker Hub
FROM jekyll/jekyll:3.8.0

# Set the working directory
WORKDIR /srv/jekyll

# Copy all project files to the Docker container
COPY . /srv/jekyll

# Update rubygems to the latest version
RUN gem update --system

# Install bundle dependencies
RUN bundle install


# Install bundle dependencies
RUN bundle install

# Expose port 4000 for the Jekyll server
EXPOSE 4000

# Run Jekyll in development mode
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
