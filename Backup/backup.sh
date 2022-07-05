#!/bin/bash

# Console Menu Interface for BorgBackup

version="0.00A"
blankline="/bin/echo -e -n \n"
BORG_PASSPHRASE="Helios009!!009Helios"
cleverecho="/bin/echo -e -n"

option=$1
backupname=$2
file1=$3
file2=$4
file3=$5

# Server Locations

backup_location1="/Servers/Backups/Servers/Borg.Master"
backup_location1notes="Master Backup of All Servers"

backup_location2="/Servers/Backups/Servers/backup.aleksd2000.at"
backup_location2notes=""

backup_location3="/Servers/Backups/Servers/obsidian.aleksd2000.cc"
backup_location3notes=""

# To do list
    #   Menu interface


menu.main() {
    if [ -f /Servers/Backups/.backup-config ]; then
        source /Servers/Backups/.backup-config
    else 
        $cleverecho "Configuration File not found.\n"
        exit
    fi

    until [[ "$menuselection" = "Q" ]] | [[ "$menuselection" = "q" ]]; do
        $cleverecho "$(basename "$0") \t\t\t\t\t\t\t\t\t\t Version: $version\n\n"
        $blankline
        $cleverecho "\t\tS) Set Backup Location\n"
        $cleverecho "\t\t   Backup Location: $backup_location\n"
        $blankline
        $cleverecho "Selection: "
        read menuselection
        case $menuselection in
            [Qq])   exit;;
            [Ss]) $cleverecho "Enter Backup Location: "
                read backup_location
                
                $blankline
                $cleverecho "\tC)   Create Backup\n"
                $cleverecho "\tD)   Delete Backup\n"
                $cleverecho "\tL)   List Existing Backups\n"
                $blankline
                $cleverecho "Selection: "
                read selection
                case $selection in
                    [Cc])   $cleverecho "What Directories do you wish to backup?: "
                            read filestobackup
                            $cleverecho "Enter New Name of Backup: "
                            read backup_name
                            $cleverecho "borg create --stats -v $backup_location::$backup_name $filestobackup "
                            ;;
                    [Ll])   borg list $backup_location;;
                esac
        esac
    done

    $cleverecho "List Backups at $backup_location?: "
    read yesno
    case $yesno in
        [Yy]) borg list $backup_location;;
        [Nn]) echo ok;;
    esac
}

menu.main


