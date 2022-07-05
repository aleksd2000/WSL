# Notes

    if pidof -x borg >/dev/null; then
        echo "Backup already running"
        exit
	fi

    $cleverecho "The following Borg Backup Locations are initialised: \n"
    $cleverecho "\n"

    if [ "$server_location1" != "" ]; then
        $cleverecho "\t Server 1: $server_location1\n"
        $cleverecho "\t Notes: $server_location1notes\n"        
        $cleverecho "\n"
    fi

    if [ "$server_location2" != "" ]; then
        $cleverecho "\t Server 2: $server_location2\n"
        $cleverecho "\t Notes: $server_location2notes\n"        
        $cleverecho "\n"
    fi

    if [ "$server_location3" != "" ]; then
        $cleverecho "\t Server 3: $server_location3\n"
        $cleverecho "\t Notes: $server_location3notes\n"        
        $cleverecho "\n"
    fi

    $cleverecho "Do you wish to list the Archives found at $location: "
    read yesno
    case $yesno in
        Y) list-archives;;
        y) list-archives;;
        N) echo ok;;
        n) echo ok;;
    esac

    $cleverecho "Do you wish to create a new archive at $location: "
    read yesno
    case $yesno in
        Y)  $cleverecho "Please enter a comment for this backup: "
            read backupcomment
            $cleverecho "Please enter the directory you wish to backup: "
            read filestobackup
 	        sudo borg create -v --stats                          	\
	            $location::$HOSTNAME-`date +%Y-%m-%d`-HOME          \
	            /home/                                              \
                --comment '$borg.comment'                           \
		        --exclude '/home/aleks/.cache'                      \

            ;;
        y)  borg create -v --stats --progress $location::$HOSTNAME $filestobackup --comment "$backupcomment";;
        N)  echo ok;;
        n)  echo ok;;

list-archives() {
    borg list $location
}
