function login_websocket(){
    if  [ "$1" = "root" ]; then
        docker exec -it -w /home/app/www_socket app_gesang bash
    else 
        docker exec -it -u app -w /home/app/www_socket app_gesang bash
    fi
}
function login_gesang(){
    if  [ "$1" = "root" ]; then
        docker exec -it -w /home/app/www_gesang/www_view app_gesang bash
    else 
        docker exec -it -u app -w /home/app/www_gesang/www_view app_gesang bash
    fi
}
function login_brain(){
     if  [ "$1" = "root" ]; then
        docker exec -it -w /home/app/www_brain/www_backend app_gesang bash
    else 
        docker exec -it -u app -w /home/app/www_brain/www_backend app_gesang bash
    fi
}
function run_chat(){
    docker exec -it -u app app_gesang bash -c 'php /home/app/www_socket/bin/IsGesangChat.php'
}
function run_gesang(){
    docker exec -it -u app -w /home/app/www_gesang/www_view app_gesang bash -c 'npm run dev'
}