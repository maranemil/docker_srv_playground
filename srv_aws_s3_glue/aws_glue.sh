# stand alone
docker run -it -p 8888:8888 -p 4040:4040 -e DISABLE_SSL="true" -v tmp:/home/glue_user/workspace/jupyter_workspace \
 --name glue_jupyter amazon/aws-glue-libs:glue_libs_3.0.0_image_01 /home/glue_user/jupyter/jupyter_start.sh
