#!/usr/bin/env bash

echo '#################################'
echo '##### Welcome to the script #####'
echo '#################################'
echo '--------------Menu---------------'
echo '1) Install soft'
echo '2) VagrantBox '


install() {
    echo 'Type 1 to install vagrant'
    echo 'Type 2 to install virtualbox'
    echo 'Type 3 to check install'
    echo 'Type 4 to exit'

    operations="1 2 3 4 5"
    PS3="Select operation: "
        select operation in $operations 
        do 
            if [ $operation == '1' ]
            then 
                sudo apt install vagrant
            fi
            if [ $operation == '2' ]
            then
                sudo apt install virtualbox-qt
            fi
            if [ $operation == '3' ]
            then
                vagrantIns=false
                virtualIns=false
                if [[ -n $(dpkg -l | grep 'vagrant') ]]
                then 
                vagrantIns=true
                echo "Vagrant is install : $vagrantIns"
                else 
                echo "Vagrant is not install"
                fi
                if [[ -n $(dpkg -l | grep 'virtualbox-qt') ]]
                then 
                virtualIns=true
                echo "VirtualBox is install : '$virtualIns'"
                else 
                echo "VirtualBox is not install"
                fi
            fi
            if [ $operation == '4' ]
            then 
                exit
            fi
        done
}
    
initbox() {
    echo 'Hey Mate Wanna init a vagrant ? Y/N'
    read res 
    if [ "$res" == 'Y' ]
    then 
        ## Choice of directory
        echo 'First we need a directory'
        path=$(pwd)
        echo 'We create a directory here '$path' ? Y/N'
        read res
        ## Create a directory in the folder of the script
        if [ "$res" == 'Y' ]
        then
            read -p 'Name of the new directory ?' directoryName
            mkdir $directoryName && cd $directoryName
            ## Vagrant file
            echo 'Lets configure Vagrantfile '
            sleep 0.5
            optionsBoxes=("Ubuntu Xenial64" "Ubuntu Xenial64")
            echo -e 'Plz select a box : '
            select boxes in "${optionsBoxes[@]}"
                do
                    case "$boxes" in 
                        "Ubuntu Xenial64" ) box='ubuntu/xenial64';break;;
                        "Ubuntu Xenial64" ) box='ubuntu/xenial64';break;;
                    esac
                done
            read -p 'Name of data folder ? ' dataFolDerName
            mkdir $dataFolDerName
            read -p 'Name of synced folder ? ' folderName
            folder='config.vm.synced_folder "./'$dataFolDerName'", "/var/www/'$folderName'"'
            read -p 'Ip address ? ' ip
            echo 'Vagrant.configure(2) do |config|
            config.vm.box="'$box'"
            config.vm.network "private_network", ip: "'$ip'"
            '$folder'
            end' > Vagrantfile 
            vagrant up
            vagrant ssh
        fi
        ## Create a directory in another folder
        elif [ "$res" == 'N' ]
        then 
            echo 'So where u wanna go ?'
            read input
            echo $input
            desti=$(find /home -name $input)
            cd $desti
            read -p "Name of the new directory ?" directoryName
            mkdir $directoryName && cd $directoryName
            pwd
            ## Vagrant file
            echo 'Lets configure Vagrantfile '
            sleep 0.5
            optionsBoxes=("Ubuntu Xenial64" "Ubuntu Xenial64")
            echo -e 'Plz select a box : '
            select boxes in "${optionsBoxes[@]}"
                do
                    case "$boxes" in 
                        "Ubuntu Xenial64" ) box='ubuntu/xenial64';break;;
                        "Ubuntu Xenial64" ) box='ubuntu/xenial64';break;;
                    esac
                done
            read -p 'Name of data folder ? ' dataFolDerName
            mkdir $dataFolDerName
            read -p 'Name of synced folder ? ' folderName
            folder='config.vm.synced_folder "./'$dataFolDerName'", "/var/www/'$folderName'"'
            read -p 'Ip address ? ' ip
            echo 'Vagrant.configure(2) do |config|
            config.vm.box="'$box'"
            config.vm.network "private_network", ip: "'$ip'"
            '$folder'
            end' > Vagrantfile
            vagrant up 
            vagrant ssh
    else
        break
    fi
}

read answer 

case "$answer" in
        1) install;;
        2) initbox;;
        3) exit;;
esac