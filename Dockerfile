FROM tomcat:8-jre8
MAINTAINER Cyrille Nofficial<cynoffic@cyrilix.fr>

ENV SUBSONIC_VERSION 5.3

LABEL version="$SUBSONIC_VERSION"
LABEL description="Subsonic media streamer"

RUN     apt-get update &&\
        apt-get -y install libav-tools lame &&\
        mkdir -p /opt/data/transcode /opt/music/ /opt/playlist/ /opt/podcast/ &&\
        ln -s /usr/bin/lame /opt/data/transcode/lame &&\
        ln -s /usr/bin/avconv /opt/data/transcode/ffmpeg &&\
        cd  ${CATALINA_HOME}/webapps/ &&\
        wget "http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION-war.zip?r=http%3A%2F%2Fwww.subsonic.org%2Fpages%2Fdownload2.jsp%3Ftarget%3Dsubsonic-$SUBSONIC_VERSION-standalone.tar.gz&ts=1431096340&use_mirror=garr" \
        -O subsonic.war.zip --quiet  &&\
        unzip subsonic.war.zip && rm subsonic.war.zip

ENV JAVA_OPTS="-Dsubsonic.home=/opt/data -Dsubsonic.defaultMusicFolder=/opt/music/ -Dsubsonic.defaultPodcastFolder=/opt/podcast/ -Dsubsonic.defaultPlaylistFolder=/opt/playlist/"

VOLUME /opt/data
VOLUME /opt/music/
VOLUME /opt/playlist/
VOLUME /opt/podcast/

EXPOSE 8080
WORKDIR /opt/subsonic
