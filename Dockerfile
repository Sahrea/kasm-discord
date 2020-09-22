FROM kasmweb/core:1.7.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


# Install Discord
RUN wget -O /tmp/discord.deb https://discordapp.com/api/download?platform=linux&format=deb && apt-get install -y /tmp/discord.deb

# Enabled Single Application Mode - No desktop environment will be spawned
COPY xfce4-desktop-single-app.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ENV SINGLE_APPLICATION=1
RUN apt-get remove -y xfce4-panel

ENV LAUNCH_URL  http://kasmweb.com

COPY custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
