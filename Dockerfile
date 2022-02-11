FROM openjdk:11-jdk-slim-buster

ENV TZ="Asia/Shanghai" 

WORKDIR /root

COPY wkhtmltox_0.12.6-1.buster_amd64.deb /root/wkhtmltox_0.12.6-1.buster_amd64.deb

COPY SimSun.ttf SimHei.ttf  /root/.fonts/

RUN apt-get update \
    && ( dpkg -i wkhtmltox_0.12.6-1.buster_amd64.deb || apt -f -y install ) \
    && dpkg -i wkhtmltox_0.12.6-1.buster_amd64.deb \
    && apt-get clean \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists

CMD ["wkhtmltopdf"]