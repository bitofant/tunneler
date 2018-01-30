FROM node:alpine
MAINTAINER joeran.tesse@iteratec.de

# ENV HOST localhost
# ENV PORT 27017
ENV TUNNEL 8099
# ENV SECRET secret password
# ENV IS_SERVER true

ENV HOME /root

EXPOSE ${TUNNEL}

WORKDIR $HOME
COPY . $HOME
RUN cd $HOME && npm install
CMD ["npm","start"]
