###############################################################################
#                                  Builder                                    #
###############################################################################
FROM node:20-alpine as builder

RUN apk add --no-cache bash

WORKDIR /app

COPY . .

RUN bash build.sh

###############################################################################
#                                   Runtime                                   #
###############################################################################
FROM node:20-alpine

WORKDIR /app

RUN yarn global add s3rver && \
    apk add --no-cache python3 py3-pip bash && \
    pip install awscli --break-system-packages

COPY --from=builder /app/build /app/build 

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 4569

ENTRYPOINT ["entrypoint.sh"]


