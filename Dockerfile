FROM ubuntu
ARG ONBUILD_VARIABLE
RUN env
RUN echo "ONBUILD=${ONBUILD_VARIABLE}"
RUN echo "${ONBUILD_VARIABLE}" > /tmp/build-var

CMD ["bash", "-c", "echo '----[ Env ] ----' && env | grep RUNTIME &&  echo '----[ Build variable ]----' && cat /tmp/build-var"]
