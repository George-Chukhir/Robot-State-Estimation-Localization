
FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y \ 
    git \
    nano \
    vim \
    ros-noetic-robot-localization \ 
    ros-noetic-gmapping \
    ros-noetic-pointcloud-to-laserscan \
    ros-noetic-velodyne-pointcloud \
    ros-noetic-octomap-server \
    ros-noetic-map-server \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/catkin_ws/src

COPY . /root/catkin_ws/src/leg_kilo

WORKDIR /root/catkin_ws

#docker uses sh, so we tell him to use bash and execute these commands 
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

#to make ROS in  container ready to work
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

CMD ["bash"]




