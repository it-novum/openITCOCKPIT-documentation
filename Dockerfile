FROM alpine:3.18

RUN apk update && apk add python3 py3-pip py3-wheel git
RUN apk add python3-dev gcc g++ make automake
RUN pip install mkdocs && \
pip install mkdocs-material && \
pip install markdown-include && \
pip install mkdocs-glightbox


EXPOSE 8000

CMD ["/usr/bin/mkdocs", "serve"]

