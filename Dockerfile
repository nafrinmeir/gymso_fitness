FROM nginx:latest

# Copy custom configuration file from the current directory
# to the Nginx configuration directory
# --- COPY nginx.conf /etc/nginx/nginx.conf

# Copy the static content into the Nginx document root
COPY . /usr/share/nginx/index.html

# Expose port 8083
EXPOSE 8083

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
