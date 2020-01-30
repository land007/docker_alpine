FROM alpine:latest

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash tar net-tools vim curl wget unzip screen util-linux git subversion && \
	rm -rf /var/cache/apk/*


#RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ADD check.sh / \
	analytics.sh / \
	start.sh / \
	task.sh /
RUN sed -i 's/\r$//' /*.sh ; chmod +x /*.sh && \
	echo $(date "+%Y-%m-%d_%H:%M:%S") >> /.image_times && \
	echo $(date "+%Y-%m-%d_%H:%M:%S") > /.image_time && \
	echo "land007/alpine" >> /.image_names && \
	echo "land007/alpine" > /.image_name

#CMD /etc/init.d/ssh start && /start.sh && bash
#ENTRYPOINT /etc/init.d/ssh start && bash
CMD /task.sh ; /start.sh ; bash

#docker build -t land007/alpine:latest .
#docker rm -f alpine ; docker run -it --privileged --name alpine land007/alpine:latest
#> docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t land007/alpine --push .
