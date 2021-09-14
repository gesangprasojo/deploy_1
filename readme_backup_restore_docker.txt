
Docker version 20.10.3, build 48d30b5

# commit container to new image
docker commit -p [idContainer] [name_new_image]

# save image
docker save [image_id] | gzip -c > [name_export.tgz]

#restore image
gunzip -c [name_file_to_load.tgz] | docker load

*note : retoring name repository and name tag must be same with image before backup  
# step 1
 *important : u must be remember name repository and tag  before to pull container from image 
- rename respository & tag name 
# rename commend :
docker image tag [container id] [repository_name]:[tag_name]
test

