FROM nginx:alpine

# (Optional) Statische Test-Website hinzufügen
COPY ./html /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
