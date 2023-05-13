ARG FROM
FROM $FROM

COPY environment.yml environment.yml
ARG CLI
RUN $CLI env update -q -v -n base
