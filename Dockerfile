# Use official Ruby 3.2.2 base image
FROM ruby:3.2.2

# Set working directory
WORKDIR /app

# Copy Gemfile and install dependencies
COPY Gemfile ./
RUN gem install bundler && bundle install

# Copy the rest of your application
COPY . .

# Expose the default Sinatra port
EXPOSE 4567

# Start the Sinatra app
CMD ["ruby", "app.rb", "-o", "0.0.0.0"]
