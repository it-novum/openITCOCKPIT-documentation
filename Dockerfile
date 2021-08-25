FROM alpine:latest

RUN apk update && apk add python3 py3-pip
RUN pip install mkdocs && \
pip install mkdocs-material && \
pip install markdown-include

EXPOSE 8000

CMD ["/usr/bin/mkdocs", "serve"]

