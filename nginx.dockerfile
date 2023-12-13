FROM nginx:latest
COPY ./.nginx/reverse-proxy.conf /etc/nginx/conf.d/reverse-proxy.conf
EXPOSE 8000
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
