FROM alpine:3.6

RUN apk add --no-cache php7

COPY index.php /index.php

ENTRYPOINT ["php"]
CMD ["-S", "0.0.0.0:80"]
