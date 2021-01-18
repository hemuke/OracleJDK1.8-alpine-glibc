FROM alpine:3.12.1
LABEL maintainer="hemuke@126.com jre-8u271-linux-x64"

# 清理临时文件要在 同一个RUN命令内进行， rm -rf .....，构建的时候每个RUN都会创建一个临时的容器，只有写在同一个RUN下才会在一个容器内执行
RUN apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-bin-2.31-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-i18n-2.31-r0.apk && \
    apk add glibc-bin-2.31-r0.apk glibc-i18n-2.31-r0.apk glibc-2.31-r0.apk && \
    rm -rfv glibc-bin-2.31-r0.apk glibc-i18n-2.31-r0.apk glibc-2.31-r0.apk /var/cache/apk/*

RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

ADD ./jdk-8u271-linux-x64.tar.gz /usr/java/jdk/

ENV JAVA_HOME=/usr/java/jdk/jdk1.8.0_271
ENV JRE_HOME=/usr/java/jdk/jdk1.8.0_271/jre
ENV CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JRE_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
